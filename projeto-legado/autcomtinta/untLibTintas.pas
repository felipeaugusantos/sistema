unit untLibTintas;

interface

uses
  untILibTinta, untIAutcomTintaWrapper;

type
  TGetTintadeMaquina = function(const autcomTintaWrapper: IAutcomTintaWrapper): ILibTinta; stdcall;

implementation

end.
