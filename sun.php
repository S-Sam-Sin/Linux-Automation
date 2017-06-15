<?php

class Sun
{
    private $_return;
    private $_sun;
    private $_bash;

    public function __construct(string $return, int $latitude, int $longtitude)
    {
        if ($return == "str" OR EMPTY($return))
        {
            $this->_return = SUNFUNCS_RET_STRING; ### Return as string
        }
        elseif ($return == "dbl")
        {
            $this->_return = SUNFUNCS_RET_DOUBLE; ### Return as float
        }
        else
        {
            $this->_return = SUNFUNCS_RET_TIMESTAMP; ### Return as timestamp
        }

        $this->_sun = date_sun_info(strtotime(date("H:i:s")), $latitude, $longtitude);
        $count = 0;
        foreach ($this->_sun as $info)
        {
            # remove seconds
            echo $this->_bash[$count] = substr( date("H:i:s",$info), 0, 5)." ";
            $count++;
        }
    }

    public function __destruct()
    {
        // TODO: Implement __destruct() method.
    }
}
$sun = new Sun($argv[1], $argv[2], $argv[3]);