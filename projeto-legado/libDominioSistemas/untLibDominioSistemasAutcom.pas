unit untLibDominioSistemasAutcom;

interface

uses Data.DB, Uni, untInterfacesLibDominioSistemasAutcom, untTypesSistema,
     Vcl.Forms, Vcl.StdCtrls, EditFocus, System.SysUtils ;

type
  TILibDominioSistemasAutcom = Class(TInterfacedObject, ILibDominioSistemas)
    function fICriaQuery: TUniQuery;
    function fICampoTabela(strCampo : String;
                           strNomTab: String;
                           arrCampoChave: Array Of String;
                           arrValorChave: Array Of Variant;
                           blnSempreLerBanco: Boolean = True;
                           strOrderBy: String = '';
                           Conexao: TUniConnection = Nil;
                           blnUsarMax: Boolean = False): Variant;
    function fIGetEmpresaLogada: String;
    function fICfgSis(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = ''): Variant;
    procedure pIValidaProCod(strNomeTabela: String);
    function fIRetAutoIncrem(strNomeTabela, strCodEmp: String; intIntervalo: Integer = -1): String;
    function fIExecutandoModoClassico: Boolean;
    function fIMensagem(const strTitulo: String; const strTexto: String; arrOpcoes: Array Of String;
      intFocoBotao: Integer = 1; blnSaiComEsc: Boolean = False; intEstFon: Integer = 1; intWidBut: Integer = 0;
      blnAutoSize: Boolean = False; intSomarTop: Integer = 0): Integer;
    procedure pIMensagensErro(const MensErro, LocalErro: String; const strMensagem: String = '');
    procedure pIGravarErro(const GravarErro:Boolean; const MensagemErro: String);
    function fIEhAdministrador(strCodOpe: String): Boolean;
    function fIRetOperadorLogado: String;
    function fIRetEmpresaLogada: String;
    procedure fIRegistraCallStackSeEstiverEmTransacao(objConexao: TUniConnection = Nil; strTextoComplementarAoCallStack: String = '');
    function fIRetNomeEmpresa: String; overload;
    function fIRetNomeEmpresa(strCodEmp: String): String; overload;
    function fITiraCaracEspeciais(strTexto      : String;
                                 blnUsaLista   : Boolean = True;
                                 blnTiraEspacos: Boolean = False;
                                 blnTiraPontos : Boolean = False;
                                 blnTiraDoisPts: Boolean = False;
                                 blnTiraTab    : Boolean = False;
                                 blnTiraVirgula: Boolean = True;
                                 blnTiraAbreviacaoNumero: Boolean = False;
                                 strCaracterePersonalizado: String = ''): String;
    function fIDataValida(dtaData: TDateTime): Boolean;
    function fIValidaPeriodo(strDtaIni, strDtaFin: String): Boolean;
    function fIPesqEmpresa(opcTipCon: TTipoConsultaEmpresa;
                       ASelf     : TForm;                          {* Formulário                                  *}
                       edtCodigo: TCustomEdit;                     {* Edit do Código                              *}
                       edtNomEmp: TEditFocus;                      {* Edit do Nome da Empresa                     *}
                       qryTabela: TUniQuery;                       {* Query                                       *}
                       Var chrKey: Char;                           {* Key                                         *}
                       Var arrSel: TConsultasArray;                {* Array de Seleção                            *}
                       blnConSim: Boolean = True): Boolean;        {* Tipo de Movimento                         *}
    function fIChamaTelaGravando(fExecutarAcao: TFunctionFormGravando; strTitulo: String = ''; blnStayOnTop: Boolean = False): Boolean;
    procedure pIFreeAndNil(var frmForm; ARemoverPilha : Boolean = False);
    Procedure pIMensagemOk(strMensagem: String; intWidth: Integer = 0; intHeight: Integer = 0);
    procedure pICriarForm(ClasseForm: TFormClass; NomeForm: TForm);
    function fITelaGravandoAntiga: Boolean;
  end ;

implementation

uses
  untFuncoesSimples, untConsultas ;

{ TILibDominioSistemasAutcom }

function TILibDominioSistemasAutcom.fICampoTabela(strCampo, strNomTab: String;
  arrCampoChave: array of String; arrValorChave: array of Variant;
  blnSempreLerBanco: Boolean; strOrderBy: String; Conexao: TUniConnection;
  blnUsarMax: Boolean): Variant;
begin
  Result := untFuncoesSimples.fCampoTabela(strCampo,
                                           strNomTab,
                                           arrCampoChave,
                                           arrValorChave,
                                           blnSempreLerBanco,
                                           strOrderBy,
                                           Conexao,
                                           blnUsarMax);
end;

function TILibDominioSistemasAutcom.fICfgSis(strCamCfg: String;
  varTipVar: TVarType; strCodEmp: String): Variant;
begin
  Result := untFuncoesSimples.fCfgSis(strCamCfg, varTipVar, strCodEmp);
end;

function TILibDominioSistemasAutcom.fIChamaTelaGravando(
  fExecutarAcao: TFunctionFormGravando; strTitulo: String;
  blnStayOnTop: Boolean): Boolean;
begin
  Result := untFuncoesSimples.fChamaTelaGravando(fExecutarAcao,
                                                 strTitulo) ;
end;

function TILibDominioSistemasAutcom.fICriaQuery: TUniQuery;
begin
  Result := untFuncoesSimples.fCriaQuery;
end;

function TILibDominioSistemasAutcom.fIDataValida(dtaData: TDateTime): Boolean;
begin
  Result := untFuncoesSimples.fDataValida(dtaData) ;
end;

function TILibDominioSistemasAutcom.fIEhAdministrador(
  strCodOpe: String): Boolean;
begin
  Result := untFuncoesSimples.fEhAdministrador(strCodOpe) ;
end;

function TILibDominioSistemasAutcom.fIExecutandoModoClassico: Boolean;
begin
  {$IF Declared(VS_AUTCOM_SEM_SUPORTE_SKIN)}
  Result := True;
  {$ELSE}
  Result := blnUsuarioLogadoUtilizaModoClassico;
  {$ENDIF}
end;

function TILibDominioSistemasAutcom.fIGetEmpresaLogada: String;
begin
  Result := untFuncoesSimples.VS_strCodEmp;
end;

function TILibDominioSistemasAutcom.fIMensagem(const strTitulo,
  strTexto: String; arrOpcoes: array of String; intFocoBotao: Integer;
  blnSaiComEsc: Boolean; intEstFon, intWidBut: Integer; blnAutoSize: Boolean;
  intSomarTop: Integer): Integer;
begin
  Result := untFuncoesSimples.fMensagem(strTitulo,
                                        strTexto,
                                        arrOpcoes,
                                        intFocoBotao,
                                        blnSaiComEsc,
                                        intEstFon,
                                        intWidBut,
                                        blnAutoSize,
                                        intSomarTop);
end;

function TILibDominioSistemasAutcom.fIPesqEmpresa(
  opcTipCon: TTipoConsultaEmpresa; ASelf: TForm; edtCodigo: TCustomEdit;
  edtNomEmp: TEditFocus; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim: Boolean): Boolean;
begin
  Result := untConsultas.fPesqEmpresa(opcTipCon,
                                      ASelf,
                                      edtCodigo,
                                      edtNomEmp,
                                      qryTabela,
                                      chrKey,
                                      arrSel,
                                      blnConSim) ;
end;

procedure TILibDominioSistemasAutcom.fIRegistraCallStackSeEstiverEmTransacao(
  objConexao: TUniConnection; strTextoComplementarAoCallStack: String);
begin
  untFuncoesSimples.fRegistraCallStackSeEstiverEmTransacao(objConexao,
                                                           strTextoComplementarAoCallStack);

end;

function TILibDominioSistemasAutcom.fIRetAutoIncrem(strNomeTabela,
  strCodEmp: String; intIntervalo: Integer): String;
begin
  Result := untFuncoesSimples.fRetAutoIncrem(strNomeTabela, strCodEmp, intIntervalo);
end;

function TILibDominioSistemasAutcom.fIRetEmpresaLogada: String;
begin
  Result := untFuncoesSimples.VS_strCodEmp;
end;

function TILibDominioSistemasAutcom.fIRetNomeEmpresa: String;
begin
  Result := untFuncoesSimples.fRetNomeEmpresa ;
end;

function TILibDominioSistemasAutcom.fIRetNomeEmpresa(strCodEmp: String): String;
begin
  Result := untFuncoesSimples.fRetNomeEmpresa(strCodEmp) ;
end;

function TILibDominioSistemasAutcom.fIRetOperadorLogado: String;
begin
  Result := untFuncoesSimples.strLoginUsuarioLogado;
end;

function TILibDominioSistemasAutcom.fITelaGravandoAntiga: Boolean;
begin
  Result := {$IF Declared(VS_AUTCOM_SEM_SUPORTE_SKIN)}True{$ELSE}False{$ENDIF};
end;

function TILibDominioSistemasAutcom.fITiraCaracEspeciais(strTexto: String;
  blnUsaLista, blnTiraEspacos, blnTiraPontos, blnTiraDoisPts, blnTiraTab,
  blnTiraVirgula, blnTiraAbreviacaoNumero: Boolean;
  strCaracterePersonalizado: String): String;
begin
  Result := untFuncoesSimples.fTiraCaracEspeciais(strTexto,
                                                  blnUsaLista,
                                                  blnTiraEspacos,
                                                  blnTiraPontos,
                                                  blnTiraDoisPts,
                                                  blnTiraTab,
                                                  blnTiraVirgula,
                                                  blnTiraAbreviacaoNumero,
                                                  strCaracterePersonalizado) ;
end;

function TILibDominioSistemasAutcom.fIValidaPeriodo(strDtaIni,
  strDtaFin: String): Boolean;
begin
  Result := untFuncoesSimples.fValidaPeriodo(strDtaIni, strDtaFin) ;
end;

procedure TILibDominioSistemasAutcom.pICriarForm(ClasseForm: TFormClass;
  NomeForm: TForm);
begin
  untFuncoesSimples.pCriarForm(ClasseForm, NomeForm) ;
end;

procedure TILibDominioSistemasAutcom.pIFreeAndNil(var frmForm;
  ARemoverPilha: Boolean);
begin
  untFuncoesSimples.pFreeAndNil(frmForm);
end;

procedure TILibDominioSistemasAutcom.pIGravarErro(const GravarErro: Boolean;
  const MensagemErro: String);
begin
  untFuncoesSimples.pGravarErro(GravarErro, MensagemErro);
end;

procedure TILibDominioSistemasAutcom.pIMensagemOk(strMensagem: String; intWidth,
  intHeight: Integer);
begin
  untFuncoesSimples.pMensagemOk(strMensagem, intWidth, intHeight);
end;

procedure TILibDominioSistemasAutcom.pIMensagensErro(const MensErro, LocalErro,
  strMensagem: String);
begin
  untFuncoesSimples.pMensagensErro(MensErro, LocalErro, strMensagem);
end;

procedure TILibDominioSistemasAutcom.pIValidaProCod(strNomeTabela: String);
begin
  untFuncoesSimples.pValidaProCod(strNomeTabela) ;
end;

end.
