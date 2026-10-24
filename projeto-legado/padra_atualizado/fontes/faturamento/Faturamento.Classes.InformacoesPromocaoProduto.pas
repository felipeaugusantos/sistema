unit Faturamento.Classes.InformacoesPromocaoProduto;

interface

type
  TInformacoesPromocaoProdutoInput = record
    strCodIte : String;
    strCodCli : String;
    strCodCnd : String;
    strTabPre : String;
    fltQtdIte : Double;
    intPrzMed : Integer;
    strEntRet : String;
    strEntFut : String;
    strMotFut : String;
    fltQtdJaDig : Double;
    fltQtdJaEmPromoc : Double;
  End;

  TInformacoesPromocaoProdutoOutput = record
    strPromoc : String;
    fltProCus : Double;
    fltProVen : Double;
    fltProCva : Double;
    fltDesF07 : Double;
    fltProCat : Double;
    fltProCdi : Double;
    fltQtdDis : Double;
    strComPro : String;
    strCodPro : String;
  End;

  TInformacoesPromocaoProduto = class
  public
    function fGetInformacoesDoProdutoEmPromocao(const AVerificaPromocaoProdutoInput: TInformacoesPromocaoProdutoInput): TInformacoesPromocaoProdutoOutput;
  End;

implementation

uses
 {$IFDEF LINUX}
  Services.Core.Utils,
 {$ELSE}
  untFuncoesSimples,
 {$ENDIF}
  untCadPro;

{ TInformacoesPromocaoProdut }

function TInformacoesPromocaoProduto.fGetInformacoesDoProdutoEmPromocao(const AVerificaPromocaoProdutoInput: TInformacoesPromocaoProdutoInput): TInformacoesPromocaoProdutoOutput;
  Var
    blnParticiona : Boolean;
    blnPromo : Boolean;
begin
  FillChar(Result, SizeOf(Result), #0);
  Result.strPromoc := 'N';
  blnParticiona := False;
  blnPromo := False;
  If (fRetornaPrecosPromocao(AVerificaPromocaoProdutoInput.strCodIte,
                             AVerificaPromocaoProdutoInput.strCodCli,
                             VS_Date,
                             AVerificaPromocaoProdutoInput.fltQtdIte,
                             AVerificaPromocaoProdutoInput.fltQtdJaDig,
                             AVerificaPromocaoProdutoInput.fltQtdJaEmPromoc,
                             AVerificaPromocaoProdutoInput.intPrzMed,
                             Result.fltProCus,
                             Result.fltProVen,
                             Result.fltProCva,
                             Result.fltProCat,
                             Result.fltProCdi,
                             Result.fltQtdDis,
                             Result.fltDesF07,
                             Result.strComPro,
                             Result.strCodPro,
                             blnParticiona,
                             blnPromo,
                             AVerificaPromocaoProdutoInput.strTabPre,
                             AVerificaPromocaoProdutoInput.strCodCnd,
                             '',
                             '',
                             True,
                             False,
                             '-1',
                             ((AVerificaPromocaoProdutoInput.strEntRet = 'E') And (AVerificaPromocaoProdutoInput.strEntFut = 'N')),
                             ((AVerificaPromocaoProdutoInput.strEntRet = 'E') And (AVerificaPromocaoProdutoInput.strEntFut = 'S')),
                             AVerificaPromocaoProdutoInput.strMotFut)) Then
  Begin
    If blnParticiona Then
    Begin
      FillChar(Result, SizeOf(Result), #0);
      Result.strPromoc := 'N';
      Exit;
    End;
    Result.strPromoc := 'S';
  End;
end;

end.
