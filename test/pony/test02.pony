       // vim:debug=msg
        type A is (I32 | U32)

use "collections"
use time = "time"

actor Main
//
/**
   */
  """
  hello
  """
"""
world
"""
  new hi(env: Env) => 3

  fun no() =>
    /**
   * comment
       */
    let s = "hi"
"hi"
let fn = lambda (s: String): Bool => x.size() > 3 end

  new create(env: Env) =>
    let child_pid = @fork[I32]()
    match child_pid
| -1 =>
          env.err.print("Failed to fork the process")
          if true then
        env.exitcode(((1))//(
)
    else
      env.exitcode(0)
            end
      | 0 if true =>
      /*---- Note
     * Calling pony functions in the child is not thread-safe?
         * /*
       *  * TODO something /* XXX: hi */
       FIXME
         *  */
     *------------*/
      //env.out.print("This sentence is true.")
      //env.exitcode(-1)
      @printf[I32]("This sentence is true.\n".cstring())
    @exit[None](I32(-1))
    else
        var wstatus: I32 = 0
      let woption: I32 = 0
        if @waitpid[I32](child_pid, addressof wstatus, woption) < 0 then
          env.err.print("Failed to wait for the child process")
          env.exitcode(1)
        else
          env.out.print("This sentence is false.")
          env.out.print("The child process exited with status: " +
              ((wstatus >> 8) and 0xFF).string())
        end
    end
"""A""""
""""""""
"""B""""
