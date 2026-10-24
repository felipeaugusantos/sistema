{**************************************************}
{* UNIT COM AS FUNCOES DO ECF (IMPRESSORA FISCAL) *}
{*                                                *}
{* MODELO....: (GENERICA)                         *}
{* DATA......: 27/02/2007                         *}
{* AUTOR.....: MARCOS VINÍCIUS DA SILVA           *}
{*                                                *}
{***********************************************MA*}
unit untDaruma;

interface

Uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StrUtils, Uni;

  {function Daruma_FI_LeituraX: Integer; StdCall; External 'Daruma32.dll';
  function Daruma_FI_ReducaoZ(Data: String; Hora: String): Integer; StdCall; External 'Daruma32.dll';
  function Daruma_FI_AcionaGaveta: Integer; StdCall; External 'Daruma32.dll';
  function Daruma_FI_RelatorioGerencial(Texto: String): Integer; StdCall; External 'Daruma32.dll';
  function Daruma_FI_RetornoImpressora(Var ACK: Integer; Var ST1: Integer; Var ST2: Integer): Integer; StdCall; External 'Daruma32.dll';
  function Daruma_FI_VerificaImpressoraLigada: Integer; StdCall; External 'Daruma32.dll';
  function Daruma_FI_AbreCupom(CGC_CPF: Pchar): Integer; StdCall; External 'Daruma32.dll';
  function Daruma_FI_AumentaDescricaoItem(Descricao: String): Integer; StdCall; External 'Daruma32.dll';
  function Daruma_FI_VendeItem(Codigo: String; Descricao: String; Aliquota: String; TipoQuantidade: String; Quantidade: String; CasasDecimais: Integer; ValorUnitario: String; TipoDesconto: String; Desconto: String): Integer; StdCall; External 'Daruma32.dll';
  function Daruma_FI_IniciaFechamentoCupom(AcrescimoDesconto: String; TipoAcrescimoDesconto: String; ValorAcrescimoDesconto: String): Integer; StdCall; External 'Daruma32.dll';
  function Daruma_FI_EfetuaFormaPagamento(DescricaoFormaPagamento: String; ValorFormaPagamento: String): Integer; StdCall; External 'Daruma32.dll';
  function Daruma_FI_TerminaFechamentoCupom(Mensagem: String): Integer; StdCall; External 'Daruma32.dll';
  function Daruma_FI_RetornoAliquotas(Aliquotas: String): Integer; StdCall; External 'Daruma32.dll';
  function Daruma_FI_CancelaCupom: Integer; StdCall; External 'Daruma32.dll';
  function Daruma_FI_LeituraMemoriaFiscalData(DataInicial: String; DataFinal: String): Integer; StdCall; External 'Daruma32.dll';
  function Daruma_FI_LeituraMemoriaFiscalReducao(ReducaoInicial: String; ReducaoFinal: String): Integer; StdCall; External 'Daruma32.dll';
  function Daruma_FI_ProgramaFormasPagamento(FormaPagto: String): Integer; StdCall; External 'Daruma32.dll';
  function Daruma_FI_VerificaFormasPagamentoEx(FormasPagamento: String): Integer; StdCall; External 'Daruma32.dll';
  function Daruma_FI_NumeroSerie(strNumSer: String): Integer; StdCall; External 'Daruma32.dll';
  function Daruma_FI_NumeroCupom(strNumCoo: String): Integer; StdCall; External 'Daruma32.dll';
  function Daruma_FI_LerAliquotasComIndice(AliquotasComIndice: String): Integer; StdCall; External 'Daruma32.dll';}

type
  TarrFormasPagto = Array of String[16];

  TUntDaruma = class(TObject)

  constructor Create;

  private
    function fRetTotalImpressora(fltQtdIte, fltUnitar: Double): Double;
    function fRetTotalSistema(fltQtdIte, fltUnitar: Double): Double;

  public
    arrNomesFormasPagto: TarrFormasPagto;

    procedure pSetPatDll( strPatDll: String );
    function  fGetPatDll: String;
    function  fInicia: Integer;
    function  fFinaliza: Integer;

    function  fLeituraX: Integer;
    function  fReducaoZ(strData, strHora: String): Integer;
    function  fAbreGaveta: Integer;
    function  fRelatorioGerencial( Texto: String ): Integer;
    function  fRetorno( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer ): Integer;
    function  fImpressoraLigada: Integer;
    function  fAbreCupom( CNPJ_CPF: String='' ): Integer;
    function  fVendeItem( strCodIte, strDescri: String; strAlqTri: String; strTipQtd: String; fltQuanti: Double; intQtdDec: Integer; fltUnitar: Double; strTipDes: String; fltDesEsp: Double): Integer;
    function  fIniciaFechamentoCupom( strAcrDes, strTipDes: String; fltDesEsp: Double ): Integer;
    function  fEfetuaFormaPagamentoDescricao( strCodMod: String; fltValFpg: Double; strDesPar: String ): Integer;
    function  fTerminaFechamentoCupom( strObserv: String ): Integer;
    function  fRetornaAliquotas( Var strAliquotas: String ): Integer;
    function  fCancelaCupom: Integer;
    function  fLeituraMF_Data(strDtaIni, strDtaFin: String): Integer;
    function  fLeituraMF_Reducao(strRedIni, strRedFin: String): Integer;
    function  fNumeroSerie(Var strNumSer: String): Integer;
    function  fRetornaCoo(Var strNumCoo: String): Integer;
    function  fLerAliquotasComIndice(Var strAliquotas: String): Integer;

    function  fProgramaFormaPagamento(strFormaPagto: String) : Integer;
    function  fVerificaFormasPagamento(var strFormasPagamento: String) : Integer;
    function  fLeNomesFormasPagamento: Integer;
    procedure pLeNomesFormasPagamentoBanco(Var arrFormasBanco: TarrFormasPagto);
    function  fCadastraFormasPagamento: integer;
    function  fArredonda(fltValor: Double): Double;
    function  fVerificaCupomAberto: Boolean;
  End;

Var
  Daruma : TUntDaruma;
  Handle : THandle;

  Daruma_FI_LeituraX: function(): Integer; StdCall;
  Daruma_FI_ReducaoZ: function(Data: String; Hora: String): Integer; StdCall;
  Daruma_FI_AcionaGaveta: function(): Integer; StdCall;
  Daruma_FI_RelatorioGerencial: function(Texto: String): Integer; StdCall;
  Daruma_FI_RetornoImpressora: function(Var ACK: Integer; Var ST1: Integer; Var ST2: Integer): Integer; StdCall;
  Daruma_FI_VerificaImpressoraLigada: function(): Integer; StdCall;
  Daruma_FI_AbreCupom: function(CGC_CPF: Pchar): Integer; StdCall;
  Daruma_FI_AumentaDescricaoItem: function(Descricao: String): Integer; StdCall;
  Daruma_FI_VendeItem: function(Codigo: String; Descricao: String; Aliquota: String; TipoQuantidade: String; Quantidade: String; CasasDecimais: Integer; ValorUnitario: String; TipoDesconto: String; Desconto: String): Integer; StdCall;
  Daruma_FI_IniciaFechamentoCupom: function(AcrescimoDesconto: String; TipoAcrescimoDesconto: String; ValorAcrescimoDesconto: String): Integer; StdCall;
  Daruma_FI_EfetuaFormaPagamento: function(DescricaoFormaPagamento: String; ValorFormaPagamento: String): Integer; StdCall;
  Daruma_FI_TerminaFechamentoCupom: function(Mensagem: String): Integer; StdCall;
  Daruma_FI_RetornoAliquotas: function(Aliquotas: String): Integer; StdCall;
  Daruma_FI_CancelaCupom: function(): Integer; StdCall;
  Daruma_FI_LeituraMemoriaFiscalData: function(DataInicial: String; DataFinal: String): Integer; StdCall;
  Daruma_FI_LeituraMemoriaFiscalReducao: function(ReducaoInicial: String; ReducaoFinal: String): Integer; StdCall;
  Daruma_FI_ProgramaFormasPagamento: function(FormaPagto: String): Integer; StdCall;
  Daruma_FI_VerificaFormasPagamentoEx: function(FormasPagamento: String): Integer; StdCall;
  Daruma_FI_NumeroSerie: function(strNumSer: String): Integer; StdCall;
  Daruma_FI_NumeroCupom: function(strNumCoo: String): Integer; StdCall;
  Daruma_FI_LerAliquotasComIndice: function(AliquotasComIndice: String): Integer; StdCall;
  Daruma_FI_StatusCupomFiscal: function (strStatus: String): Integer; StdCall;

implementation

uses  untfuncoesSimples, untFiscal;

Var
  strDllDaruma  : String;

{*****************************************}
{* CONSTRUTOR                            *}
{**************************************MA*}
constructor TUntDaruma.Create;
begin
  strDllDaruma := '';
end;

{*****************************************}
{* SETA PATH DA DLL                      *}
{**************************************MA*}
procedure TUntDaruma.pSetPatDll( strPatDll: String );
begin
  strDllDaruma := strPatDll;
end;

{*****************************************}
{* OBTEM PATH DA DLL                     *}
{**************************************MA*}
function TUntDaruma.fGetPatDll: String;
begin
  Result := strDllDaruma;
end;

{*****************************************}
{* INICIA BEMATECH                       *}
{**************************************MA*}
function TUntDaruma.fInicia: Integer;
Begin
  If FileExists( strDllDaruma ) Then
  Begin
    Handle := LoadLibrary(PChar(strDllDaruma));

    Daruma_FI_LeituraX := GetProcAddress(Handle, pChar('Daruma_FI_LeituraX'));
    Daruma_FI_ReducaoZ := GetProcAddress(Handle, pChar('Daruma_FI_ReducaoZ'));
    Daruma_FI_AcionaGaveta := GetProcAddress(Handle, pChar('Daruma_FI_AcionaGaveta'));
    Daruma_FI_RelatorioGerencial := GetProcAddress(Handle, pChar('Daruma_FI_RelatorioGerencial'));
    Daruma_FI_RetornoImpressora := GetProcAddress(Handle, pChar('Daruma_FI_RetornoImpressora'));
    Daruma_FI_VerificaImpressoraLigada := GetProcAddress(Handle, pChar('Daruma_FI_VerificaImpressoraLigada'));
    Daruma_FI_AbreCupom := GetProcAddress(Handle, pChar('Daruma_FI_AbreCupom'));
    Daruma_FI_AumentaDescricaoItem := GetProcAddress(Handle, pChar('Daruma_FI_AumentaDescricaoItem'));
    Daruma_FI_VendeItem := GetProcAddress(Handle, pChar('Daruma_FI_VendeItem'));
    Daruma_FI_IniciaFechamentoCupom := GetProcAddress(Handle, pChar('Daruma_FI_IniciaFechamentoCupom'));
    Daruma_FI_EfetuaFormaPagamento := GetProcAddress(Handle, pChar('Daruma_FI_EfetuaFormaPagamento'));
    Daruma_FI_TerminaFechamentoCupom := GetProcAddress(Handle, pChar('Daruma_FI_TerminaFechamentoCupom'));
    Daruma_FI_RetornoAliquotas := GetProcAddress(Handle, pChar('Daruma_FI_RetornoAliquotas'));
    Daruma_FI_CancelaCupom := GetProcAddress(Handle, pChar('Daruma_FI_CancelaCupom'));
    Daruma_FI_LeituraMemoriaFiscalData := GetProcAddress(Handle, pChar('Daruma_FI_LeituraMemoriaFiscalData'));
    Daruma_FI_LeituraMemoriaFiscalReducao := GetProcAddress(Handle, pChar('Daruma_FI_LeituraMemoriaFiscalReducao'));
    Daruma_FI_ProgramaFormasPagamento := GetProcAddress(Handle, pChar('Daruma_FI_ProgramaFormasPagamento'));
    Daruma_FI_VerificaFormasPagamentoEx := GetProcAddress(Handle, pChar('Daruma_FI_VerificaFormasPagamentoEx'));
    Daruma_FI_NumeroSerie := GetProcAddress(Handle, pChar('Daruma_FI_NumeroSerie'));
    Daruma_FI_NumeroCupom := GetProcAddress(Handle, pChar('Daruma_FI_NumeroCupom'));
    Daruma_FI_LerAliquotasComIndice := GetProcAddress(Handle, pChar('Daruma_FI_LerAliquotasComIndice'));
    Daruma_FI_StatusCupomFiscal := GetProcAddress(Handle, pChar('Daruma_FI_StatusCupomFiscal'));

    Result := 0;
  End
  Else
  Begin
    Result := -999;
  End;
End;

{*****************************************}
{* FINALIZA BEMATECH                     *}
{**************************************MA*}
function TUntDaruma.fFinaliza: Integer;
Begin
  FreeLibrary(Handle);
  Result := 0;
End;

{*****************************************}
{* LEITURA X                             *}
{**************************************MA*}
function TUntDaruma.fLeituraX: Integer;
begin
  Result := Daruma_FI_LeituraX();
end;

{*****************************************}
{* REDUCAO Z                             *}
{**************************************MA*}
function TUntDaruma.fReducaoZ(strData, strHora: String): Integer;
begin
  Result := Daruma_FI_ReducaoZ(PChar(strData),PChar(strHora));
end;

{*****************************************}
{* RETORNO DA IMPRESSORA                 *}
{**************************************MA*}
function TUntDaruma.fRetorno( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer ): Integer;
Begin
  Result := Daruma_FI_RetornoImpressora( ACK, ST1, ST2 );

  //Quando OK retorna ACK = 6 mas ST1 e ST2 = 0
  //Nesse caso nao tem q fazer nada
  If Result = 1 Then
    If ( ST1 + ST2 ) = 0 Then
      Result := 1
    Else
      Result := StrToInt( RightStr( '000' + Trim( IntToStr( ACK ) ), 3 ) +
                          RightStr( '000' + Trim( IntToStr( ST1 ) ), 3 ) +
                          RightStr( '000' + Trim( IntToStr( ST2 ) ), 3 ) );

End;

{*****************************************}
{* RELATORIO GERENCIAL                   *}
{**************************************MA*}
function TUntDaruma.fRelatorioGerencial( Texto: String ): Integer;
Begin
  Result := Daruma_FI_RelatorioGerencial( Texto );
End;

{*****************************************}
{* VERIFICA IMPRESSORA LIGADA            *}
{**************************************MA*}
function TUntDaruma.fImpressoraLigada: Integer;
Begin
  Result := Daruma_FI_VerificaImpressoraLigada();
End;

{*****************************************}
{* ABRE CUPOM FISCAL                     *}
{**************************************MA*}
function TUntDaruma.fAbreCupom( CNPJ_CPF: String='' ): Integer;
Begin
  Result := Daruma_FI_AbreCupom( PChar( CNPJ_CPF ) );
End;

{*****************************************}
{* VENDE ITEM                            *}
{**************************************MA*}
function TUntDaruma.fVendeItem( strCodIte, strDescri: String; strAlqTri: String; strTipQtd: String; fltQuanti: Double; intQtdDec: Integer; fltUnitar: Double; strTipDes: String; fltDesEsp: Double): Integer;
  Var
    strQuanti : String;
    strQtdDec : String;
    strUnitar : String;
    strDesEsp : String;
    fltUltDesEspIte: Double;
    fltUltAcrescIte: Double;
Begin
  strQuanti := FloatToStrF( fltQuanti, ffNumber, 10, 3 );
  strQtdDec := RightStr( '00' + Trim( IntToStr( intQtdDec ) ), 2 );
  strUnitar := FloatToStrF( fltUnitar, ffNumber, 8, 2 );

  pCalculaAcrDesItem(Self.fRetTotalImpressora, Self.fRetTotalSistema, fStrToFloat(strQuanti), fStrToFloat(strUnitar),
    fltQuanti, fltUnitar, fltDesEsp, fltUltDesEspIte, fltUltAcrescIte);

  {*****************************************}
  {* NESTE CASO, QUANDO TEM QUE APLICAR    *}
  {* ACRÉSCIMO, MANDA UM VALOR NEGATIVO PA-*}
  {* RA O DESCONTO.                        *}
  {**************************************MA*}
  If fltUltDesEspIte > 0 Then
  Begin
    strDesEsp := FloatToStrF(fltUltDesEspIte, ffNumber, 8, 2);
  End
  Else
  Begin
    strDesEsp := FloatToStrF(-fltUltAcrescIte, ffNumber, 8, 2);
  End;
  

  Result := Daruma_FI_VendeItem( strCodIte, fPadr( strDescri, 29 ), strAlqTri, strTipQtd, strQuanti, intQtdDec, strUnitar, strTipDes, strDesEsp );
End;

function TUntDaruma.fRetTotalImpressora(fltQtdIte, fltUnitar: Double): Double;
begin
  Result := fFormataFloat(fltQtdIte * fltUnitar, 2);
end;

function TUntDaruma.fRetTotalSistema(fltQtdIte, fltUnitar: Double): Double;
begin
  Result := fFormataFloat(fltQtdIte * fltUniTar, 2);
end;

{*****************************************}
{* INICIA FECHAMENTO DO CUPOM            *}
{**************************************MA*}
function TUntDaruma.fIniciaFechamentoCupom( strAcrDes, strTipDes: String; fltDesEsp: Double ): Integer;
  Var strDesEsp : String;
Begin

  strDesEsp := FloatToStrF( fltDesEsp, ffNumber, 14, 2 );
  strDesEsp := AnsiReplaceStr( strDesEsp, '.', '' );
  strDesEsp := AnsiReplaceStr( strDesEsp, ',', '' );

  Result := Daruma_FI_IniciaFechamentoCupom( strAcrDes, strTipDes, strDesEsp );
End;

{*****************************************}
{* ATRIBUI OS VALORES DAS FORMAS DE      *}
{* PAGAMENTO                             *}
{**************************************MA*}
function  TUntDaruma.fEfetuaFormaPagamentoDescricao( strCodMod: String; fltValFpg: Double; strDesPar: String ): Integer;
  Var strValFpg: String;
Begin
  strValFpg := FloatToStrF( fltValFpg, ffNumber, 12, 2 );

  If Not fEmptyStr( strDesPar ) Then
    strDesPar := fPadr( strDesPar, 80 );

  Result := Daruma_FI_EfetuaFormaPagamento( strCodMod, strValFpg );
End;

{*****************************************}
{* FINALIZA O CUPOM                      *}
{**************************************MA*}
function TUntDaruma.fTerminaFechamentoCupom( strObserv: String ): Integer;
Begin
  Result := Daruma_FI_TerminaFechamentoCupom( strObserv );
End;

{*****************************************}
{* RETORNA AS ALIQUOTAS DE ICMS          *}
{**************************************MA*}
function TUntDaruma.fRetornaAliquotas( Var strAliquotas: String ): Integer;
Begin

  strAliquotas := fPadr( strAliquotas, 79 );

  Result := Daruma_FI_RetornoAliquotas( strAliquotas );

End;

{*****************************************}
{* RETORNA AS ALIQUOTAS DE ICMS          *}
{**************************************MA*}
function TUntDaruma.fCancelaCupom: Integer;
Begin
  Result := Daruma_FI_CancelaCupom();
End;

{*******************************************}
{* ABRE GAVETA                             *}
{****************************************MV*}
function TUntDaruma.fAbreGaveta: Integer;
begin
  Result := Daruma_FI_AcionaGaveta();
end;


//*************************************************//
// LEITURA DA MEMORIA FISCAL POR DATA              //
//**********************************************ED*//
function TUntDaruma.fLeituraMF_Data(strDtaIni, strDtaFin: String): Integer;
begin

  Result := Daruma_FI_LeituraMemoriaFiscalData( pchar( strDtaIni ), pchar( strDtaFin));

end;


//*************************************************//
// LEITURA DA MEMORIA FISCAL POR REDUCAO           //
//**********************************************ED*//
function TUntDaruma.fLeituraMF_Reducao(strRedIni, strRedFin: String): Integer;
begin
  Result := Daruma_FI_LeituraMemoriaFiscalReducao( pchar( strRedIni ), pchar( strRedIni));
end;

{*****************************************}
{* CADASTRA FORMA DE PAGAMENTO           *}
{**************************************LA*}
function TUntDaruma.fProgramaFormaPagamento(strFormaPagto: String) : Integer;
Begin
  Result := Daruma_FI_ProgramaFormasPagamento( PChar( strFormaPagto ) );
End;

function TUntDaruma.fVerificaCupomAberto: Boolean;
var strStatus: string;
begin
  SetLength (strStatus, 2);
  Daruma_FI_StatusCupomFiscal( PChar( strStatus ) );

  If Trim(strStatus) = '1' Then
    Result:=True
  Else
    Result:=False;
end;

function TUntDaruma.fVerificaFormasPagamento(var strFormasPagamento: String) : Integer;
Begin
  strFormasPagamento := fPadr( strFormasPagamento, 3016 );
  Result := Daruma_FI_VerificaFormasPagamentoEX( strFormasPagamento );
end;

function TUntDaruma.fLeNomesFormasPagamento: Integer;
  Var
    strNome, strFormasPagamento: String;
Begin
  Result := fVerificaFormasPagamento(strFormasPagamento);
//  intIndex := 1;
  if Result = 1 Then
  Begin
    SetLength(arrNomesFormasPagto,0);
    While pos(',',strFormasPagamento) > 0 Do
    Begin
      strNome := Trim(Copy(strFormasPagamento,1,16));
      If strNome <> '' Then
      Begin
        Setlength(arrNomesFormasPagto,Succ(Length(arrNomesFormasPagto)));
        arrNomesFormasPagto[High(arrNomesFormasPagto)] := ShortString(strNome);
      End;
    End;
    Delete(strFormasPagamento,1,57);
    SetLength(arrNomesFormasPagto,Pred(Length(arrNomesFormasPagto)));
  End;
End;

procedure TUntDaruma.pLeNomesFormasPagamentoBanco(Var arrFormasBanco: TarrFormasPagto);
  Var
    strSQL: String;
    qryGen: TUniQuery;
    strPatIni: String;
Begin
  SetLength(arrFormasBanco,0);

  qryGen := fCriaQuery;

  strSql := '';
  strSql := strSql + ' SELECT ';
  strSql := strSql + '   * ';
  strSql := strSql + ' FROM ';
  strSql := strSql + ' ECFMOD ';
  strSql := strSql + ' WHERE ';
  strSql := strSql + '   ECF_CODECF = :CODECF ';


  With qryGen Do
  Begin

    Close;
    Sql.Clear;
    Sql.Add(strSql);
    strPatIni := fCfgSis('DIRINI');
    ParamByName('CODECF').AsString := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA', '', strPatIni + '/opcoes_fiscal.ini' );

    Open;

    First;
    while Not Eof Do
    Begin
      Setlength(arrFormasBanco,Succ(Length(arrFormasBanco)));
      arrFormasBanco[High(arrFormasBanco)] := ShortString(FieldByName('ECF_DESMOD').AsString);
      Next;
    End;

    Close;

  End;
  FreeAndNil(qryGen);

End;

function TUntDaruma.fCadastraFormasPagamento: integer;
  Var
    arrFormasBanco: TarrFormasPagto;
    intBanco, intImp: integer;
    blnAchou: boolean;
Begin
  result := fLeNomesFormasPagamento;

  pLeNomesFormasPagamentoBanco(arrFormasBanco);

  For intBanco := Low(arrFormasBanco) To High(arrFormasBanco) Do
  Begin
    blnAchou := false;
    For intImp := Low(arrNomesFormasPagto) To High(arrNomesFormasPagto) Do
       If SameText(UpperCase(Trim(String(arrFormasBanco[intBanco]))),UpperCase(Trim(String(arrNomesFormasPagto[intImp])))) Then
       Begin
         blnAchou := True;
         Break;
       End;
    If Not blnAchou Then
      result := fProgramaFormaPagamento(String(arrFormasBanco[intBanco]));
  End;

  SetLength(arrFormasBanco,0);
  SetLength(arrNomesFormasPagto,0);
End;

function TUntDaruma.fNumeroSerie(var strNumSer: String): Integer;
begin
  strNumSer := fStrEspaco(' ', 20);
  Result := Daruma_FI_NumeroSerie ( strNumSer );
end;

function TUntDaruma.fRetornaCoo(var strNumCoo: String): Integer;
begin
  strNumCoo := fStrEspaco(' ', 6);
  Result := Daruma_FI_NumeroCupom ( strNumCoo );
end;

function TUntDaruma.fArredonda(fltValor: Double): Double;
begin
  Result := fFormataFloat(fltValor,2);
end;

function TUntDaruma.fLerAliquotasComIndice(Var strAliquotas: String): Integer;
begin
 SetLength (strAliquotas, 300);
 Result := Daruma_FI_LerAliquotasComIndice(strAliquotas);
end;

End.

