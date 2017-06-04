<?php

class Sun
{
    private $_return;
    private $_sun;

    public function __construct(string $sun, string $return, int $latitude, int $longtitude, int $zenith, int $offset)
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

        if ($sun == "sunrise")
        {
            $this->GetSunRise($latitude, $longtitude, $zenith, $offset);
        }
        else
        {
            $this->GetSunSet($latitude, $longtitude, $zenith, $offset);
        }
    }

    public function GetSunRise(int $latitude, int $longtitude, int $zenith, int $offset)
    {
        echo $this->_sun = date_sunrise(time(), $this->_return, $latitude, $longtitude, $zenith, $offset);
    }

    public function GetSunSet(int $latitude, int $longtitude, int $zenith, int $offset)
    {
        echo $this->_sun = date_sunset(time(), $this->_return, $latitude, $longtitude, $zenith, $offset);
    }

    public function __destruct()
    {
        // TODO: Implement __destruct() method.
    }
}
### bash : SUN=$(php ./libraries/sun.php "sunrise" "str" ${latitude} ${longtitude} ${zenith} ${gmt_offset})
$sun = new Sun($argv[1], $argv[2], $argv[3], $argv[4], $argv[5], $argv[6]);