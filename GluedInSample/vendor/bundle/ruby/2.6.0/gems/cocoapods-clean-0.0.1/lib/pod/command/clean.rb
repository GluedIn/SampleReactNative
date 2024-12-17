module Pod
  class Command


    class Clean < Command
      self.summary = "Remove Podfile.lock, Pods/ and *.xcworkspace"

      self.description = <<-DESC
        This command will simply remove Podfile.lock, Pods/ and *.xcworkspace from the current project.
      DESC


      def initialize(argv)
        @name = argv.shift_argument
        super
      end

      def validate!
        super
      end

      def run
        system('rm -rf Podfile.lock Pods *.xcworkspace')
      end
    end
  end
end
