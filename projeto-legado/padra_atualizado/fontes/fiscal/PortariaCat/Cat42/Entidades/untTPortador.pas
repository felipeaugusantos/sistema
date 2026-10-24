unit untTPortador;

interface

uses untTypesSistema;

type
  TPortador = class
    private
      FCodigo: String;
      FNome: String;
      FContaContabil: String;
      FPosicaoContabil: string;
      FPortadores: TConsultasArray;
      FExportaAutsi: Boolean;
    public
      property strCodigo: String read FCodigo write FCodigo;
      property strNome: String read FNome write FNome;
      property strContaContabil: String read FContaContabil write FContaContabil;
      property strPosicaoContabil: string read FPosicaoContabil write FPosicaoContabil;
      property arrPortador: TConsultasArray read FPortadores write FPortadores;
      property blnExportaAutsi: Boolean read FExportaAutsi write FExportaAutsi;
  end;

implementation

end.
