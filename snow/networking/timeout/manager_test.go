// (c) 2019-2020, Ava Labs, Inc. All rights reserved.
// See the file LICENSE for licensing terms.

package timeout

import (
	"sync"
	"testing"
	"time"

	"github.com/ava-labs/gecko/ids"
)

func TestManagerFire(t *testing.T) {
	manager := Manager{}
	manager.Initialize(time.Millisecond)
	go manager.Dispatch()

	wg := sync.WaitGroup{}
	wg.Add(1)

	manager.Register(ids.NewShortID([20]byte{}), ids.NewID([32]byte{}), 0, wg.Done)

	wg.Wait()
}

func TestManagerCancel(t *testing.T) {
	manager := Manager{}
	manager.Initialize(50 * time.Millisecond)
	go manager.Dispatch()

	wg := sync.WaitGroup{}
	wg.Add(1)

	fired := new(bool)

	manager.Register(ids.NewShortID([20]byte{}), ids.NewID([32]byte{}), 0, func() { *fired = true })

	manager.Cancel(ids.NewShortID([20]byte{}), ids.NewID([32]byte{}), 0)

	manager.Register(ids.NewShortID([20]byte{}), ids.NewID([32]byte{}), 1, wg.Done)

	wg.Wait()

	if *fired {
		t.Fatalf("Should have cancelled the function")
	}
}
