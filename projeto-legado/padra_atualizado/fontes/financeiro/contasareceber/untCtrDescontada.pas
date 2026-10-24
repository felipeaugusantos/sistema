unit untCtrDescontada;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider,
   Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, QColorLabel, DBCtrls,
  BitBtnLockedIncrem, MemDS, DBAccess, Provider, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls,
  dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, untCadRec,
  untTCadRec, untTCadRecRepository, untTypesSistema, untLiberacao, cxProgressBar,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, System.UITypes,
  untFrameCentroCustoEditFocus, untFramePlanoDeContasMaskEdit;

type
  TfrmCtrDescontada = class(TfrmPaiOrdena)
    Label1: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    Label4: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    lbl2: TLabel;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    lbl3: TLabel;
    edtCodCid: TEditFocus;
    edtNomCid: TEditFocus;
    dbedtDesEvento: TDBEdit;
    lbl4: TLabel;
    lbl5: TLabel;
    dbeNomPortador: TDBEdit;
    lbl6: TLabel;
    dbeNomCidade: TDBEdit;
    lbl7: TLabel;
    edtTotGer: TEditFocus;
    lbl8: TLabel;
    edtTotSel: TEditFocus;
    lbl9: TLabel;
    edtCodReg: TEditFocus;
    edtDesReg: TEditFocus;
    pnlFormasPagto: TPanel;
    Label5: TLabel;
    edtCodFpg: TEditFocus;
    edtDesFpg: TEditFocus;
    pnlPeriodo: TPanel;
    Label9: TLabel;
    edtFiltro: TEditFocus;
    ColorLabel1: TColorLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnGravar: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    btnCarrTitulos: TBitBtnLocked;
    btnHistDocumentos: TBitBtnLocked;
    cxgConsultaTableView: TcxGridDBTableViewCitel;
    cxgConsultaLevel: TcxGridLevel;
    cxgConsulta: TcxGridCitel;
    cxgConsultaTableViewCTR_NUMDUP: TcxGridDBColumn;
    cxgConsultaTableViewCTR_PARCEL: TcxGridDBColumn;
    cxgConsultaTableViewCTR_ESPDOC: TcxGridDBColumn;
    cxgConsultaTableViewCTR_CODEMP: TcxGridDBColumn;
    cxgConsultaTableViewCTR_DTACAD: TcxGridDBColumn;
    cxgConsultaTableViewCTR_DTAVEN: TcxGridDBColumn;
    cxgConsultaTableViewCTR_CODCLI: TcxGridDBColumn;
    cxgConsultaTableViewCTR_NOMCLI: TcxGridDBColumn;
    cxgConsultaTableViewCTR_DESCON: TcxGridDBColumn;
    cxgConsultaTableViewCTR_IMPBOL: TcxGridDBColumn;
    cxgConsultaTableViewCTR_ENVBCO: TcxGridDBColumn;
    cxgConsultaTableViewCTR_CODPOR: TcxGridDBColumn;
    cxgConsultaTableViewCTR_VALDUP: TcxGridDBColumn;
    cxgConsultaTableViewAUTOINCREM: TcxGridDBColumn;
    fraCentroCusto: TfraCentroCustoEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    pnlAuxiliar: TPanel;
    Label8: TLabel;
    edtCodven: TEditFocus;
    edtNomVen: TEditFocus;
    edtQtdTotGer: TEditFocus;
    edtQtdTotSel: TEditFocus;
    lbl10: TLabel;
    lbl11: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure dbgConsultaDblClick(Sender: TObject);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodFpgExit(Sender: TObject);
    procedure edtCodFpgKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure btnCarrTitulosClick(Sender: TObject);
    procedure mskCodCtaExit(Sender: TObject);
    procedure mskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure btnMudaOrdemClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnHistDocumentosClick(Sender: TObject);
    procedure cxgConsultaTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgConsultaTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgConsultaTableViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxgConsultaTableViewDataControllerFilterChanged(Sender: TObject);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodvenExit(Sender: TObject);
    procedure edtCodvenKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodCidExit(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodRegExit(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaExit(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure fraCentroCustoedtCodEveExit(Sender: TObject);
  private
    { Private declarations }
    qryCadEmp,
    qryCadCli: TUniQuery;
    qryBuscaDadosDup  : TUniQuery;
    qryConsultaBoleto : TUniQuery;
    qryConCta         : TUniQuery;

    arrCentCusto: TConsultasArray;
    arrDuplicatas        : Array of Array of String;
    matrizDadosDuplicata : Array of String;
    listaImpressa, listaNaoImpressa : TStringList;
    strListaJaImpresso,
    strLista : String;
    objLiberacao : TLiberacao;
    cdsClone: TUniClientDataSet;

    arrVend : TConsultasArray;
    strVend : String;

    FLimparRegistros: Boolean;

    procedure pCarregaCliente;
    procedure pCarregaEmpresa;
    procedure pCalculaTotais;
    procedure pCarregaCentroCusto;
    procedure pCarregaVendedor;

    function fGetSqlTabela: String;
    Function fAlteraDuplicatas: Boolean;
    Function fGravaDuplicatas(strDescon, strCodPor, strCodEve, strCodCta: String): Boolean;
    Function fGravaTabela(strDescon, strCodPor, strCodEve, strCodCta: String): Boolean;
    Function fGetListaCaixa: String;
    function fChamaAbreConsulta(blnLike: Boolean): Boolean;
    function fAutorizaGravarDup(strLista, strCodPor:String):Boolean;
    function fPortadorDiferente(chaveDuplicata, strCodPor:String):Boolean;
    function fSenhaPortador: Boolean;
    function fBoletoJaImpresso(chaveBoleto:String):Boolean;
    procedure pGetSql;
    function  fMarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
    function  fDesmarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;


  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; Override;
    function fInLista(strValor: String): Boolean; Reintroduce; Overload;
  end;


implementation

uses untFuncoesSimples, untPesqAux, untConstantes, untConsultas,
  untCtrDescontadaConf, StrUtils, untFuncoesConsulta, untFuncFat, untGravando, untLogCtr,
  untMsgLiberacao, untRelCtrLogAcompDuplicNovo, untFuncoes, untAtualizaOcorrenciasCRM,
  untTypesCRM;

{$R *.dfm}

function TfrmCtrDescontada.fGetSqlTabela: String;
Var
  strSQL: String;
Begin
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   R.AUTOINCREM AS AUTOINCREM, ';
  strSQL := strSQL + '   CTR_NUMDUP, ';
  strSQL := strSQL + '   CTR_PARCEL, ';
  strSQL := strSQL + '   CTR_ESPDOC, ';
  strSQL := strSQL + '   CTR_CODEMP, ';
  strSQL := strSQL + '   CTR_DTACAD, ';
  strSQL := strSQL + '   CTR_DTAVEN, ';
  strSQL := strSQL + '   CTR_VALDUP, ';
  strSQL := strSQL + '   CTR_DESCON, ';
  strSQL := strSQL + '   CTR_CODPOR, ';
  strSQL := strSQL + '   CTR_CODCLI, ';
  strSQL := strSQL + '   CLI_NOMCLI AS CTR_NOMCLI, ';
  strSQL := strSQL + '   CTR_CODVEN, ';
  If (edtCodFpg.Visible) And (Not fEmptyStr(edtCodFpg.Text)) Then
    strSQL := strSQL + ' M.GER_CODFPG, N.GER_CODFPG, ';
  strSQL := strSQL + '   CONCAT(EVE_CODEVE,"-",EVE_DESEVE) AS CTR_DESEVE, ';
  strSQL := strSQL + '   CONCAT(POR_CODPOR,"-",POR_NOMPOR) AS CTR_NOMPOR, ';
  strSQL := strSQL + '   CONCAT(CID_NOMCID,"-",CID_ESTADO) AS CTR_NOMCID,  ';
  strSQL := strSQL + '   IF((CTR_NOSNUM IS NOT NULL) OR (COALESCE(CTR_BCOBOL, "")= "999" AND CTR_DTABOL IS NOT NULL), "Sim", "Não") AS CTR_IMPBOL, ';
  strSQL := strSQL + '   IF(CTR_DTAENV IS NOT NULL, "Sim", "Não") AS CTR_ENVBCO  ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADREC R ';
  strSQL := strSQL + ' INNER JOIN CADCLI ON CLI_CODCLI = CTR_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN CADEVE ON EVE_CODEVE = CTR_CODEVE ';
  strSQL := strSQL + '  LEFT JOIN CADPOR ON POR_CODPOR = CTR_CODPOR ';
  strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ';

  If (edtCodFpg.Visible) And (Not fEmptyStr(edtCodFpg.Text)) Then
  Begin
    strSQL := strSQL + '  LEFT JOIN MOVGER M ON M.GER_CODCLI = CTR_CODCLI ';
    strSQL := strSQL + '                    AND M.GER_NUMDOC = CTR_NUMDUP ';
    strSQL := strSQL + '                    AND M.GER_ESPDOC = CTR_ESPDOC ';
    strSQL := strSQL + '                    AND M.GER_CODEMP = CTR_CODEMP ';

    strSQL := strSQL + '  LEFT JOIN NOTGER N ON N.GER_CODCLI = CTR_CODCLI ';
    strSQL := strSQL + '                    AND N.GER_NUMDOC = CTR_NUMDUP ';
    strSQL := strSQL + '                    AND N.GER_ESPDOC = CTR_ESPDOC ';
    strSQL := strSQL + '                    AND N.GER_CODEMP = CTR_CODEMP ';
  End;

  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   CTR_DTAREC IS NULL ';

  If Not fEmptyStr(edtCodCli.Text) Then
    strSQL := strSQL + '  AND CTR_CODCLI = :CODCLI ';

  If Not fEmptyStr(edtCodEmp.Text) Then
    strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP '
  Else
    strSQL := strSQL + '  AND LOCATE(CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
  Begin
    If (edtFiltro.Text = 'V') Then
      strSQL := strSQL + '  AND CTR_DTAVEN BETWEEN :DTAINI AND :DTAFIN '
    Else
      strSQL := strSQL + '  AND CTR_DTACAD BETWEEN :DTAINI AND :DTAFIN ';
  End;

  If Not fEmptyStr(edtCodReg.Text) Then
    strSQL := strSQL + '  AND CLI_CODREG = :CODREG ';

  If Not fEmptyStr(edtCodCid.Text) Then
    strSQL := strSQL + '  AND CLI_CODCID = :CODCID ';

  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    strSQL := strSQL + '  AND CTR_CODEVE = :CODEVE ';

  If Not fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
  Begin
    If RightStr(fraPlanoDeContas.MskCodCta.Text, 5) = '00000' Then
      strSQL := strSQL + ' AND LEFT(CTR_CODCTA, 2) = LEFT(:CODCTA, 2) '
    Else
    If RightStr(fraPlanoDeContas.MskCodCta.Text, 3) = '000' Then
      strSQL := strSQL + ' AND LEFT(CTR_CODCTA, 4) = LEFT(:CODCTA, 4) '
    Else
      strSQL := strSQL + ' AND CTR_CODCTA = :CODCTA ';
  End;

  If Not fEmptyStr(edtCodPor.Text) Then
    strSQL := strSQL + '  AND CTR_CODPOR = :CODPOR '
  Else If fCfgSis('DACPOR', varBoolean) Then
  Begin
    strSQL := strSQL + '  AND (IFNULL(CTR_CODPOR, "") = "" ';
    strSQL := strSQL + '  OR LOCATE(CTR_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
  End;

  If (edtCodFpg.Visible) And (Not fEmptyStr(edtCodFpg.Text)) Then
    strSQL := strSQL + '  AND ((M.GER_CODFPG = :CODFPG) OR (N.GER_CODFPG = :CODFPG)) ';

  If (Not fEmptyStr(edtCodven.Text)) Then
    strSQL := strSQL + fStrLocate(edtCodven, arrVend, 'CTR_CODVEN', 'CODEVEN');

  Result := strSQL;
End;

function TfrmCtrDescontada.fPortadorDiferente(chaveDuplicata, strCodPor: String): Boolean;
Var
  strSQL: String;
  i:integer;
Begin
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   R.AUTOINCREM, ';
  strSQL := strSQL + '   CONCAT(R.CTR_NUMDUP,''-'',R.CTR_PARCEL,''-'',R.CTR_ESPDOC) AS CTR_DUPLICATA, ';
  strSQL := strSQL + '   CONCAT(R.CTR_CODCLI,''-'',CLI_NOMCLI) AS CTR_NOMCLI, ';
  strSQL := strSQL + '   R.CTR_DTACAD, ';
  strSQL := strSQL + '   R.CTR_DTAVEN, ';
  strSQL := strSQL + '   R.CTR_VALDUP, ';
  strSQL := strSQL + '   POR_CODPOR, CONCAT(POR_CODPOR,"-",POR_NOMPOR) AS CTR_NOMPOR, CTR_CODEMP ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADREC R';
  strSQL := strSQL + ' INNER JOIN CADCLI ON CLI_CODCLI = CTR_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN CADPOR ON POR_CODPOR = CTR_CODPOR ';

  strSQL := strSQL + ' WHERE ';

  if fEmptyStr(chaveDuplicata) then
  begin
    fMensagem('ATENÇÃO!', 'Chave de duplicata necessário!', ['&O k']);
    Result := False;
    Exit;
  end else
    strSQL := strSQL + '  R.AUTOINCREM = :AUTOINCREM AND POR_CODPOR <> :CODPOR  ';

  If Not fEmptyStr(edtCodEmp.Text) Then
    strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP '
  Else
    strSQL := strSQL + '  AND LOCATE(CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

  qryBuscaDadosDup.SQL.Clear;
  qryBuscaDadosDup.SQL.Add(strSQL);
  qryBuscaDadosDup.ParamByName('AUTOINCREM').AsString := StringReplace(chaveDuplicata,'''','',[rfreplaceAll]);
  qryBuscaDadosDup.ParamByName('CODPOR').AsString     := strCodPor;
  If Not fEmptyStr(edtCodEmp.Text) Then
    qryBuscaDadosDup.ParamByName('CODEMP').AsString := edtCodEmp.Text;

  qryBuscaDadosDup.Open;

  SetLength(matrizDadosDuplicata,10);
  for i:= 0 to 9 do
    matrizDadosDuplicata[i] := '';

  if not qryBuscaDadosDup.IsEmpty then
  begin
    for i:=0 to qryBuscaDadosDup.FieldCount -1 do
      matrizDadosDuplicata[i] := qryBuscaDadosDup.Fields[i].AsString;
    matrizDadosDuplicata[8] := strCodPor + '-' + fRetNomPortador(strCodPor);
  end;

  Result := matrizDadosDuplicata[1] <> '';

End;

procedure TfrmCtrDescontada.fraCentroCustoedtCodEveExit(Sender: TObject);
  Var
    arrEvento : TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(fraCentroCusto.edtCodEve, fraCentroCusto.edtDesEve, arrEvento, fRetNomEvento, nil, 'do Evento');
end;

procedure TfrmCtrDescontada.fraPlanoDeContasMskCodCtaExit(Sender: TObject);
begin
  inherited;
  fraPlanoDeContas.MskCodCtaExit(Sender);
  pEdtCodSelectExit(fraPlanoDeContas.mskCodCta, fraPlanoDeContas.edtDesCta, arrCentCusto, fRetNomeConta, Nil, 'da Conta',0,False,'Código',True);
end;


procedure TfrmCtrDescontada.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  fraPlanoDeContas.MskCodCtaKeyPress(Sender, Key);

end;

{********************************************************}
{* SENHA PARA ALTERAÇÃO DE PORTADOR NAS DUPLICATAS      *}
{*****************************************************FA*}
function TfrmCtrDescontada.fSenhaPortador: Boolean;
  Var
    i          : integer;
    duplicata, especie: String;
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;
begin
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('>> ALTERAÇÃO DE PORTADORES APÓS EMISSÃO DE BOLETOS <<');
  objLiberacao.objMsgLibera.pAddQuebra;
  objLiberacao.objMsgLibera.pAddSeparador(121);
  objLiberacao.objMsgLibera.pAddTexto('ACESSO A ALTERAÇÃO DE PORTADORES APÓS EMISSÃO DE BOLETOS', alCentro, teAmbos, '', 121);
  objLiberacao.objMsgLibera.pAddQuebra;
  objLiberacao.objMsgLibera.pAddTextoCaption('NOVO PORTADOR', Copy(arrDuplicatas[0,8],1,80), 0, alCentro, teAmbos, '', 121);
  objLiberacao.objMsgLibera.pAddQuebra;

  objTabela := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'DUPLICATA'         , 19 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'CLIENTE'           , 33 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'DT. CAD.'          , 12 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'DT. VENC.'         , 12 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'VR.DUPLICATA'      , 12 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'PORTADOR ORIGINAL' , 20 , alDireita  , teAutcom);
  objTabela.lstLinhas.Add(objLinha);

  for i:= 0 to length(arrDuplicatas)-1 do
  begin
    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlValor;
    objLinha.pAddColuna('DUPLICATA'         , arrDuplicatas[i,1]                       , 19 , alEsquerda );
    objLinha.pAddColuna('CLIENTE'           , arrDuplicatas[i,2]                                        , 33 , alEsquerda );
    objLinha.pAddColuna('DT. CAD.'          , FormatDateTime('dd/mm/yyyy', StrToDate(arrDuplicatas[i,3])) , 12 , alCentro   );
    objLinha.pAddColuna('DT. VENC.'         , FormatDateTime('dd/mm/yyyy', StrToDate(arrDuplicatas[i,4])) , 12 , alCentro   );
    objLinha.pAddColuna('VR.DUPLICATA'      , FormatFloat('#,###,##0.00', Abs(fStrToFloat(arrDuplicatas[i,5])))     , 12 , alDireita  );
    objLinha.pAddColuna('PORTADOR ORIGINAL' , Copy(arrDuplicatas[i,7],1,21)                                                                  , 20 , alDireita  );
    objTabela.lstLinhas.Add(objLinha);
  end;

  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

  objLiberacao.objMsgLibera.pAddTexto('NECESSÁRIO INFORMAÇÃO DE SENHA', alCentro, teAmbos, '', 121);
  objLiberacao.objMsgLibera.pAddSeparador(121);
  objLiberacao.objMsgLibera.pAddQuebra;
  objLiberacao.objMsgLibera.pAddTextoCaption('>> EMPRESA  SOLICITANTE', VS_strCodEmp);
  objLiberacao.objMsgLibera.pAddTextoCaption('>> OPERADOR SOLICITANTE', strLoginUsuarioLogado + ' - ' +strDescriUsuarioLogado);

  objLiberacao.strDirAce := 'ALTPORBOL';
  objLiberacao.strMsgSen := 'Senha para alteração de portador da duplicata';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  Result := objLiberacao.fLibera;

  if Result then
    for i:= 0 to length(arrDuplicatas)-1 do
    begin
      Duplicata := Copy(arrDuplicatas[i,1],1,12);
      especie   := Copy(arrDuplicatas[i,1],length(arrDuplicatas[i,1])-1,2);
      pGeraLogLiberacao(duplicata,
                        especie,
                        arrDuplicatas[i,9]);
    end;

end;

function TfrmCtrDescontada.fSetParametros: Boolean;
Begin
  Result := False;
  If Not fVerificaCampos  Then
     Exit;
  With qryConsulta Do
  Begin
    If Not fEmptyStr(edtCodCli.Text) Then
    Begin
      ParamByName('CODCLI').AsString := edtCodCli.Text;
    End;

    If Not fEmptyStr(edtCodEmp.Text) Then
    Begin
      ParamByName('CODEMP').AsString := edtCodEmp.Text;
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
    End;

    If Not fEmptyStr(edtCodReg.Text) Then
      ParamByName('CODREG').AsString := edtCodReg.Text;

    If Not fEmptyStr(edtCodCid.Text) Then
      ParamByName('CODCID').AsString := edtCodCid.Text;

    If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      ParamByName('CODEVE').AsString := fraCentroCusto.edtCodEve.Text;

    If Not fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
      ParamByName('CODCTA').AsString := fraPlanoDeContas.MskCodCta.Text;

    If Not fEmptyStr(edtCodPor.Text) Then
      ParamByName('CODPOR').AsString := edtCodPor.Text;

    If edtCodFpg.Visible Then
    Begin
      If Not fEmptyStr(edtCodFpg.Text) Then
        ParamByName('CODFPG').AsString := edtCodFpg.Text;
    End;

    If (Not fEmptyStr(edtCodven.Text)) Then
      pSetaParam(edtCodven.Text, arrVend, strVend, 'CODEVEN', qryConsulta);

  End;

  Result := TRUE;
End;

function TfrmCtrDescontada.fGetSql(blnLike: Boolean): String;
Begin
  Result := fGetSqlTabela + fFiltraSQL(blnLike);
End;

function TfrmCtrDescontada.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodCli) Then
    Begin

      If Not fEmptyStr(edtCodCli.Text) Then
      Begin
        pCarregaCliente;
        If qryCadCli.FieldByName('CLI_CODCLI').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Cliente não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End
      Else
        edtNomCli.Text := 'TODOS';

    End
    Else If (Sender = edtCodEmp) Then
    Begin

      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        edtNomEmp.Text := 'TODAS';
      End
      Else
      Begin
        If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            pCarregaEmpresa;
            If qryCadEmp.FieldByName('EMP_CODEMP').IsNull Then
            Begin
              fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&O k']);
              Result := False;
            End;
          End;
        End;
      End;

    End
    Else If (Sender = edtCodCid) Then
    Begin

      If Not fEmptyStr(edtCodCid.Text) Then
      Begin
        edtNomCid.Text := fRetNomCidade(edtCodCid.Text);

        If fEmptyStr(edtNomCid.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Cidade não está cadastrada!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        edtNomCid.Text := 'TODAS';
      End;

    End
    Else If (Sender = edtCodFpg) Then
    Begin

      If Not fEmptyStr(edtCodFpg.Text) Then
      Begin
        edtDesFpg.Text := fRetDescFpg(edtCodFpg.Text);

        If fEmptyStr(edtDesFpg.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Forma de Pagamento não está cadastrada!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        edtDesFpg.Text := 'TODAS';
      End;

    End
    Else If (Sender = edtCodReg) Then
    Begin

      If Not fEmptyStr(edtCodReg.Text) Then
      Begin
        edtDesReg.Text := fRetNomRegiao(edtCodReg.Text);

        If fEmptyStr(edtDesReg.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Região não está cadastrada!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        edtDesReg.Text := 'TODAS';
      End;

    End
    Else If (Sender = fraCentroCusto.edtCodEve) Then
    Begin

      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin
        fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve);

        If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If (fRetTipoEvento(fraCentroCusto.edtCodEve.Text)='P') Then
        Begin
          fMensagem('ATENÇÃO', 'Esse Centro de Custos pode ser aplicado somente às contas a pagar!',['&OK']);
          Result := False;
        End;

      End
      Else
      Begin
        fraCentroCusto.edtDesEve.Text := 'TODOS';
      End;

    End
    Else If (Sender = edtCodPor) Then
    Begin

      If Not fEmptyStr(edtCodPor.Text) Then
      Begin
        edtDesPor.Text := fRetNomPortador(edtCodPor.Text);

        If fEmptyStr(edtDesPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text, edtCodEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos para este portador!', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else
      Begin
        edtDesPor.Text := 'TODOS';
      End;

    End
    Else If (Sender = edtFiltro) Then
    Begin

      If (Pos(edtFiltro.Text, 'VC') <= 0) or (fEmptyStr(edtFiltro.Text)) Then
      begin
        fMensagem('ATENÇÃO!', 'O campo deve ser preenchido com "V" ou "C"!', ['&O k']);
        Result := False;
      end;

    End
    Else If (Sender = mskDtaIni) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        mskDtaFin.Clear;
        mskDtaFin.Enabled := False;
        pCalculaTotais;
      End
      Else
      Begin
        mskDtaFin.Enabled := True;
      End;

    End
    Else If (Sender = mskDtaFin) Then
    Begin

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          pCalculaTotais;
        End;
      End;

    End

    {***************************************}
    {* VALIDA CENTRO DE CUSTO              *}
    {************************************JU*}
    Else If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text)) Then
      Begin

        If fraPlanoDeContas.MskCodCta.Text <> '0' Then
           pCarregaCentroCusto;

        if fEmptyStr(fraPlanoDeContas.edtDesCta.Text) Then
        Begin
           fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
           Result := False;
        End;
      End
      Else
      Begin
        fraPlanoDeContas.edtDesCta.Text := 'TODOS';
      End;
    End

    Else If (Sender = edtCodven) Then
    Begin
      If (fEmptyStr(edtCodven.Text)) Then
      Begin
        edtNomVen.Text := 'TODOS';
      End
      Else
      If Not SameText(edtCodven.Text, '000') Then
      Begin
        SetLength(arrVend, 0);
        strVend := '';

        pCarregaVendedor;
        If fEmptyStr(edtNomVen.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Vendedor não está cadastrado!', ['&O k']);
          Result := False;
        End
      End;
    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCtrDescontada.mskCodCtaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, arrCentCusto, fRetNomeConta, Nil, 'da Conta');
end;

procedure TfrmCtrDescontada.mskCodCtaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentCusto) Then
  Begin
    If fValidaCampos(fraPlanoDeContas.MskCodCta, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCtrDescontada.pCarregaCliente;
begin
  pPesquisaCadCli(qryCadCli, qryCadCli, edtCodCli.Text);
  With qryCadCli Do
  Begin
    edtNomCli.Text := FieldbyName('CLI_NOMCLI').AsString;
  End;
end;

procedure TfrmCtrDescontada.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryCadEmp, qryCadEmp, edtCodEmp.Text);
  With qryCadEmp Do
  Begin
    edtNomEmp.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;

procedure TfrmCtrDescontada.pCarregaVendedor;
begin
  If Not fEmptyStr(edtCodven.Text) Then
    edtNomVen.Text := fRetNomVendRep(edtCodven.Text)
  Else
    edtNomVen.Clear;
end;

procedure TfrmCtrDescontada.pGetSql;
begin
  if not fChamaAbreConsulta(True) or cdsConsulta.IsEmpty then
    fMensagem('ATENÇÃO','Não há dados para ser exibir registros!',['&O K']);
end;

procedure TfrmCtrDescontada.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodCli);
end;

procedure TfrmCtrDescontada.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(cdsClone);
end;

procedure TfrmCtrDescontada.FormCreate(Sender: TObject);
begin
  inherited;
  objLiberacao := TLiberacao.Create;
  pnlFormasPagto.Visible := (fCfgSis('USAFPG', varBoolean));

  qryCadEmp         := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryCadCli         := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  qryConCta         := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  qryBuscaDadosDup  := fCriaQuery(qryBuscaDadosDup);
  qryConsultaBoleto := fCriaQuery(qryConsultaBoleto);

  blnSempreRelerBanco := FALSE;
  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := cxgConsultaTableView.Columns[0].DataBinding.FieldName;
  lflLastField.strNomCol := cxgConsultaTableView.Columns[0].Caption;
  lflLastField.ftyTipCam := ftString;

  listaImpressa := TStringList.Create;
  listaImpressa.Clear;

  listaNaoImpressa := TStringList.Create;
  listaNaoImpressa.Clear;

  {***********************************************************************}
  {* MELHORA O DESEMPENHO AO MARCAR TODOS E NAVEGAR NO GRID (OnDrawCell) *}
  {********************************************************************RP*}
  stlListSelecao.Sorted := True;
  cdsClone := TUniClientDataSet.Create(Self);

  FLimparRegistros := True;
end;

procedure TfrmCtrDescontada.FormDestroy(Sender: TObject);
begin
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
  inherited;
end;

procedure TfrmCtrDescontada.edtCodCliExit(Sender: TObject);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtNomCli, arrSel, nil, fRetNomCliente, 'do Cliente');
end;

procedure TfrmCtrDescontada.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin

  If fEntraCons(Key) Then
  Begin

    if fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, nil, Key, arrSel) then
    Begin
      Self.SelectNext(ActiveControl, True, True);
    End;

    pCarregaCliente;

  End;
  
end;

procedure TfrmCtrDescontada.btnCarrTitulosClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos  Then
     Exit
  else
  begin
    TfrmGravando.fExecutarModal(pGetSQL,'Aguarde... Carregando Títulos','');
    cxgConsultaTableView.DataController.Filter.Clear;
    stlListSelecao.Clear;
    pCalculaTotais;

    If cdsConsulta.RecordCount > 0 Then
    begin
      cdsConsulta.First;
      pSetFocus(cxgConsulta);
      pCloneDataSet(cdsClone, cdsConsulta);
      pCalculaTotais;
    end
    else
      pSetFocus(edtCodCli);
  end;
end;

procedure TfrmCtrDescontada.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  if (not cdsConsulta.Active) or (cdsConsulta.RecordCount = 0) then
  begin
    fMensagem('ATENÇÃO!', 'É necessário ter ao menos uma duplicata listada no grid!', ['&OK']);
    Exit;
  end;

  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fDesmarcarTodas;
  frmGravando.lblGravando.Caption := 'Aguarde... Desmarcando Duplicatas';
  frmGravando.ShowModal;
{  If (cdsConsulta.Active) and (cdsConsulta.RecordCount > 0) Then
  begin
    stlListSelecao.Clear;
    pCalculaTotais;
   // dbgConsulta.Refresh;
  end
  else
  begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos uma duplicata!', ['&OK']);
  end;}
end;

procedure TfrmCtrDescontada.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  if (not cdsConsulta.Active) or (cdsConsulta.RecordCount = 0) then
  begin
    fMensagem('ATENÇÃO!', 'É necessário ter ao menos uma duplicata listada no grid!', ['&OK']);
    Exit;
  end;

  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fMarcarTodas;
  frmGravando.lblGravando.Caption := 'Aguarde... Marcando Duplicatas';
  frmGravando.ShowModal;
end;

procedure TfrmCtrDescontada.btnMudaOrdemClick(Sender: TObject);
begin
  if (not cdsConsulta.Active) or (cdsConsulta.RecordCount = 0) then
  begin
    fMensagem('ATENÇÃO!', 'É necessário ter ao menos uma duplicata listada no grid!', ['&OK']);
    Exit;
  end;

  inherited;
end;

procedure TfrmCtrDescontada.btnPesquisarClick(Sender: TObject);
begin
  if (not cdsConsulta.Active) or (cdsConsulta.RecordCount = 0) then
  begin
    fMensagem('ATENÇÃO!', 'É necessário ter ao menos uma duplicata listada no grid!', ['&OK']);
    Exit;
  end;

  inherited;
end;

procedure TfrmCtrDescontada.cxgConsultaTableViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pAddListaQuery;
  pCalculaTotais;
end;

procedure TfrmCtrDescontada.cxgConsultaTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If cdsConsulta.IsEmpty Then
    Exit;

  If (blnTemSelecao Or (Assigned(stlListSelecao) And (stlListSelecao.Count > 0))) And
     fInLista(VarToStr(AViewInfo.GridRecord.Values[cxgConsultaTableViewAUTOINCREM.Index])) Then
  Begin
    If (Not AViewInfo.Selected) Then
      ACanvas.Font.Color := clBlue
    Else
      ACanvas.Font.Color := clLime;
  End;
end;

procedure TfrmCtrDescontada.cxgConsultaTableViewDataControllerFilterChanged(
  Sender: TObject);
begin
  inherited;
  pCalculaTotais;
end;

procedure TfrmCtrDescontada.cxgConsultaTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
  Begin
    pAddListaQuery;
    pCalculaTotais;
  End;
end;

procedure TfrmCtrDescontada.btnGravarClick(Sender: TObject);
begin
  inherited;
  cxgConsultaTableView.DataController.Filter.Clear;

  If stlListSelecao.Count > 0 Then
  Begin
    setlength(arrDuplicatas,0);
    setlength(matrizDadosDuplicata,0);
    If fAlteraDuplicatas Then
      fMensagem('', 'Registros alterados com sucesso!', ['&OK'])
    Else
      fMensagem('', 'Nenhum registro foi alterado!', ['&OK']);

    If FLimparRegistros Then
    Begin
      stlListSelecao.Clear;
      cdsConsulta.Close;
      edtTotGer.Clear;
      edtTotSel.Clear;
      edtQtdTotGer.Clear;
      edtQtdTotSel.Clear;
    End;

    pSetFocus(edtCodCli);
  End
  Else
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos uma duplicata!', ['&OK']);

end;

procedure TfrmCtrDescontada.btnHistDocumentosClick(Sender: TObject);
  Var
    frmRelCtrLogAcompDuplicNovo : TfrmRelCtrLogAcompDuplicNovo;
begin
  Try
    pCriarFormularios(TfrmRelCtrLogAcompDuplicNovo, frmRelCtrLogAcompDuplicNovo);
    frmRelCtrLogAcompDuplicNovo.edtCodEmpresa.Text := edtCodEmp.Text;
    frmRelCtrLogAcompDuplicNovo.edtCodCliente.Text := edtCodcli.Text;
    If(Not fEmptyStr(mskDtaIni.Text)) And(Not fEmptyStr(mskDtaFin.Text)) Then
    Begin
      frmRelCtrLogAcompDuplicNovo.mskDtaIni.Text := mskDtaIni.Text;
      frmRelCtrLogAcompDuplicNovo.mskDtaFin.Text := mskDtaFin.Text;
    End
    Else
    Begin
      frmRelCtrLogAcompDuplicNovo.mskDtaIni.Text := DateToStr(VS_DATE);
      frmRelCtrLogAcompDuplicNovo.mskDtaFin.Text := DateToStr(VS_DATE);
    End;
    frmRelCtrLogAcompDuplicNovo.edtCodOpe.Text := strLoginUsuarioLogado;
    frmRelCtrLogAcompDuplicNovo.blnVeioDescontada := True;
    frmRelCtrLogAcompDuplicNovo.pCarregaCampos;
    frmRelCtrLogAcompDuplicNovo.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmCtrDescontada.btnHistDocumentos]');
  End;
  pFreeAndNil(frmRelCtrLogAcompDuplicNovo);
end;

{******************************************************************}
{* PROCEDURE ALTERADO PARA CHAMADA DA NOVA CONSULTA DE PORTADORES *}
{***************************************************************JU*}
Function TfrmCtrDescontada.fAlteraDuplicatas: Boolean;
Begin
  Try
    FLimparRegistros := False;

    Result := FALSE;
    pCriarFormularios(TfrmCtrDescontadaConf,frmCtrDescontadaConf);
    frmCtrDescontadaConf.stlListSelecao := stlListSelecao;
    frmCtrDescontadaConf.dtsConsulta := dtsConsulta;

    Result := (frmCtrDescontadaConf.ShowModal = mrOk);

    If Not Result THen
      Exit;

    Result := fGravaDuplicatas(frmCtrDescontadaConf.edtDescon.Text,
                               frmCtrDescontadaConf.edtCodPor.Text,
                               frmCtrDescontadaConf.fraCentroCusto.edtCodEve.Text,
                               frmCtrDescontadaConf.fraPlanoDeContas.MskCodCta.Text);

    FLimparRegistros := True;
  Finally
    FreeAndNil(frmCtrDescontadaConf);
  End;
End;

function TfrmCtrDescontada.fAutorizaGravarDup(strLista, strCodPor: String): Boolean;
Var
  strListDup:TStringList;
  i,j : integer;
begin
  Result := True;

  if fEmptyStr(strCodPor) then
    Exit;
  
  strListDup           := TStringList.Create;

  // explodo a lista das duplicatas dentro de uma matriz para buscar uma a uma
  extractStrings([','],[' '], PChar(strLista), strListDup);

  for i:=0 to strListDup.Count -1 do
    // função para consultar específicamente o portador dentro de um select
    // caso no select seja retornado valor é porque já nele o parametro de consulta
    // strCodPor deve ser diferente do que está registrado em banco
    // caso retorne verdadeiro, já retorna uma matriz global da unit com os dados daquele
    // registro para inserção em uma matriz final que deverá ser informada a tela de senha

    if fPortadorDiferente(strListDup[i], strCodPor) then
    begin
      SetLength(arrDuplicatas,length(arrDuplicatas)+1);
      SetLength(arrDuplicatas[length(arrDuplicatas)-1],10);

      for j:=0 to 9 do
        arrDuplicatas[length(arrDuplicatas)-1,j] := matrizDadosDuplicata[j];

    end;

  if length(arrDuplicatas) > 0 then
    Result := fSenhaPortador;
end;

function TfrmCtrDescontada.fBoletoJaImpresso(chaveBoleto: String): Boolean;
begin


  qryConsultaBoleto.SQL.Clear;
  qryConsultaBoleto.SQL.Add(' SELECT CTR_NOSNUM FROM CADREC WHERE AUTOINCREM = :CHAVE ');
  qryConsultaBoleto.ParamByName('CHAVE').AsString := StringReplace(chaveBoleto,'''','',[rfreplaceAll]);
  qryConsultaBoleto.Open;

  Result := not fEmptyStr(qryConsultaBoleto.FieldByName('CTR_NOSNUM').AsString);

end;

function TfrmCtrDescontada.fChamaAbreConsulta(blnLike: Boolean): Boolean;
begin
  If (fCfgSis('DACPOR', varBoolean)) And
     Not (fEmptyStr(edtCodPor.Text)) Then
  Begin
    If Not fValidaCampos(edtCodPor) Then
    Begin
      Result       := False;
      blnMudarFoco := False;
      Exit;
    End;
  End;

  Result := fAbreConsulta(blnLike);
end;

Function TfrmCtrDescontada.fGetListaCaixa: String;
  Var
    intIndice: Integer;
    sltLista : TStringList;
    strAutInc: String;

Begin
  sltLista := TStringList.Create;
  sltLista.Clear;

  For intIndice := 0 To stlListSelecao.Count - 1 Do
  Begin
    strAutInc := Copy(stlListSelecao[intIndice],2,21);

    sltLista.Add(QuotedStr(LeftStr(strAutInc,20)));

    if fBoletoJaImpresso(Copy(stlListSelecao[intIndice],2,21)) then
      listaImpressa.Add(QuotedStr(LeftStr(strAutInc,20)))
    else
      listaNaoImpressa.Add(QuotedStr(LeftStr(strAutInc,20)))

  End;

  strListaJaImpresso  := listaImpressa.CommaText;

  Result := sltLista.CommaText;
End;

Function TfrmCtrDescontada.fGravaTabela(strDescon, strCodPor, strCodEve, strCodCta: String): Boolean;
  Var
    qryCadRec: TUniQuery;

    LAlteracaoPortador : Boolean;
    LDataTrocaPortador : TDateTime;
    LPortadorAnterior : String;
Begin
  Try
    Result   := False;

    if listaImpressa.Count > 0 then
      strLista := listaImpressa.CommaText;
    if (listaImpressa.Count > 0) and (listaNaoImpressa.Count > 0) then
      strLista := strLista + ',' + listaNaoImpressa.CommaText;
    if (listaImpressa.Count = 0) and (listaNaoImpressa.Count > 0) then
      strLista := listaNaoImpressa.CommaText;
    if (listaImpressa.Count = 0) and (listaNaoImpressa.Count = 0) then
      strLista := '';

    If Not fEmptyStr(strLista) Then
    Begin
      qryCadRec := fCriaQuery;

      With qryCadRec, SQL Do
      Begin
        Close;
        Clear;
        Add('SELECT ');
        Add('  AUTOINCREM, CTR_NUMDUP, CTR_PARCEL, CTR_ESPDOC,');
        Add('  CTR_CODEMP, CTR_CODCLI, CTR_SEQBAI, CTR_DESCON,');
        Add('  CTR_CODPOR, CTR_CODEVE, CTR_CODCTA ');
        Add('FROM CADREC');
        Add('WHERE AUTOINCREM IN (' + strLista + ')');
        Open;

        LAlteracaoPortador     := False;
        LDataTrocaPortador := VS_Date;

        qryCadRec.First;
        While not qryCadRec.Eof Do
        Begin
          LPortadorAnterior  := qryCadRec.FieldByName('CTR_CODPOR').AsString;
          If (LPortadorAnterior <> strCodPor) Then
          Begin
            LAlteracaoPortador := True;
            Break;
          End;
          qryCadRec.Next;
        End;

        If (LAlteracaoPortador) Then
        Begin
          If fCampoTabela('POR_TITPDD', 'CADPOR', ['POR_CODPOR'], [LPortadorAnterior]) = 'S' Then
            LDataTrocaPortador := TGravaAlteracaoDePortador.RetornaDataPortadorAnterior(qryCadRec.FieldByName('CTR_NUMDUP').AsString,
                                                                               qryCadRec.FieldByName('CTR_PARCEL').AsString,
                                                                               qryCadRec.FieldByName('CTR_ESPDOC').AsString,
                                                                               qryCadRec.FieldByName('CTR_CODEMP').AsString,
                                                                               qryCadRec.FieldByName('CTR_CODCLI').AsString,
                                                                               qryCadRec.FieldByName('CTR_SEQBAI').AsString);

          If Not fValidaPortadorDataPDD(strCodPor,
                                        qryCadRec.FieldByName('CTR_CODEMP').AsString,
                                        LDataTrocaPortador,
                                        fCampoTabela('POR_TITPDD', 'CADPOR', ['POR_CODPOR'], [LPortadorAnterior]) = 'S') Then
          Begin
             fMensagem('ATENÇÃO', 'Operação cancelada!', ['&O k']);
             Result := False;
            Exit;
          End;
        End;


        qryCadRec.First;
        while not qryCadRec.Eof do
        begin
          qryCadRec.Edit;

          If Not fEmptyStr(strDescon) Then
            FieldByName('CTR_DESCON').AsString := strDescon;

          If Not fEmptyStr(strCodPor) Then
            FieldByName('CTR_CODPOR').AsString := strCodPor;

          If Not fEmptyStr(strCodEve) Then
            FieldByName('CTR_CODEVE').AsString := strCodEve;

          If Not fEmptyStr(strCodCta) Then
            FieldByName('CTR_CODCTA').AsString := strCodCta;

          qryCadRec.Post;

          TGravaAlteracaoDePortador.SalvarManualmente(LPortadorAnterior,
                                                       strCodPor,
                                                       qryCadRec.FieldByName('CTR_NUMDUP').AsString,
                                                       qryCadRec.FieldByName('CTR_PARCEL').AsString,
                                                       qryCadRec.FieldByName('CTR_ESPDOC').AsString,
                                                       qryCadRec.FieldByName('CTR_CODEMP').AsString,
                                                       qryCadRec.FieldByName('CTR_CODCLI').AsString,
                                                       qryCadRec.FieldByName('CTR_SEQBAI').AsString,
                                                       False,
                                                       LDataTrocaPortador);
          qryCadRec.Next;
        end;
      End;
      FreeAndNil(qryCadRec);
      Result := True;
    End;

  Except

    On E: Exception Do
    Begin
      Result := FALSE;
      pMensagensErro('Erro ao atualizar duplicatas. ' + E.Message , '[fGravaTabela]');
    End;

  End;

End;

function TfrmCtrDescontada.fInLista(strValor: String): Boolean;
begin
  If blnQuoteLista Then
    Result := (stlListselecao.IndexOf('''' + strValor + '''') > -1) Or
              (stlListselecao.IndexOf(strValor) > -1)
  Else
    Result := stlListselecao.IndexOf(strValor) > -1;
end;

function TfrmCtrDescontada.fMarcarTodas(pgbStatus: TcxProgressBar): Boolean;
begin
  Result := True;
  If (cdsConsulta.Active) and (cdsConsulta.RecordCount > 0) Then
  Begin
    stlListSelecao.Clear;
    With cdsConsulta Do
    Begin
      cxgConsultaTableView.BeginUpdate;
      DisableControls;
      First;
      While Not Eof Do
      Begin
        pProgresso(RecNo, RecordCount, pgbStatus);
        pAddListaQuery;
        Next;
      End;
      cxgConsultaTableView.EndUpdate;
      EnableControls;
    End;

    pCalculaTotais;
   // dbgConsulta.Refresh;
  End
  else
  begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos uma duplicata!', ['&OK']);
  end;
end;

Function TfrmCtrDescontada.fGravaDuplicatas(strDescon, strCodPor, strCodEve, strCodCta: String): Boolean;
Var
    qryTabela: TUniQuery;
Begin

  Application.ProcessMessages;

  Try
    listaNaoImpressa.Clear;
    listaImpressa.Clear;

    strLista := fGetListaCaixa;

    //  inicio a busca de autorização para gravação dos registros.
    //  passo a lista com as duplicatas marcadas para poder consultar uma a uma
    //  se o portador em especifico é diferente e com elas construir uma matriz
    //  para informar a tela de senha.

    if (listaImpressa.Count > 0) and (not fAutorizaGravarDup(strListaJaImpresso,strCodPor)) then
      listaImpressa.Clear;

    fStartTransaction;

    Result := fGravaTabela(strDescon, strCodPor, strCodEve, strCodCta);

    If Result Then
    Begin
      qryTabela := fCriaQuery;
      qryTabela.SQL.Text := 'SELECT * FROM CADREC WHERE AUTOINCREM IN (' + strLista + ')';
      qryTabela.Open;

      qryTabela.First;
      While Not qryTabela.Eof Do
      Begin
        untLogCtr.GravaLogCtr(qryTabela.FieldByName('AUTOINCREM').AsString, 'ALTERAÇÃO', Self.Name);

        If VS_strHabilitarCRM And (Not fEmptyStr(fCfgSis('OCOFIN', varString)))  Then
        Begin
          TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(qryTabela.FieldByName('CTR_NUMDUP').AsString,
                                                   qryTabela.FieldByName('CTR_ESPDOC').AsString,
                                                   qryTabela.FieldByName('CTR_CODEMP').AsString,
                                                   qryTabela.FieldByName('CTR_CODCLI').AsString,
                                                   qryTabela.FieldByName('CTR_PARCEL').AsString,
                                                   strLoginUsuarioLogado,
                                                   fRetCgcCpf(qryTabela.FieldByName('CTR_CODCLI').AsString),
                                                   afcAlteraPorDesEvento);
        End;
        qryTabela.Next;
      End;
      qryTabela.Close;
      FreeAndNil(qryTabela);

      fCommit;
    End
    Else
      fRollBack;

  Except

    On E: Exception Do
    Begin
      fRollBack;
      Result := FALSE;
      pMensagensErro('Erro ao atualizar duplicatas. ' + E.Message , '[fGravaDuplicatas]');
    End;

  End;


End;

procedure TfrmCtrDescontada.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  Case Key Of
    VK_F3    : btnMudaOrdem.Click;
    VK_F10   : btnGravar.Click;
    VK_F7    : btnMarcaTodos.Click;
    VK_F8    : btnDesmarcaTodos.Click;
    VK_F5    : btnPesquisar.Click;
    VK_ESCAPE: If edtCodCli.Focused Then
                 inherited
               Else
               Begin
                 if pnlPesquisa.Visible Then
                   inherited
                 Else
                 Begin
                   cdsConsulta.Close;
                   pCalculaTotais;
                   pSetFocus(edtCodCli);
                   Abort;
                 End;
               End;

    Else inherited;
  End;

end;

procedure TfrmCtrDescontada.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodCli);
end;

procedure TfrmCtrDescontada.edtCodEmpExit(Sender: TObject);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmp, nil, fRetNomeEmpresaSelec, 'da Empresa',0,False,'Código',True);
end;

procedure TfrmCtrDescontada.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
    
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

{******************************************************************}
{* PROCEDURE ALTERADO PARA CHAMADA DA NOVA CONSULTA DE PORTADORES *}
{***************************************************************JU*}
procedure TfrmCtrDescontada.edtCodPorExit(Sender: TObject);
var
   arrSel: TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtCodPor, edtDesPor, arrSel, nil, fRetNomPortador, 'do Portador');
end;

procedure TfrmCtrDescontada.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel: TConsultasArray;

begin
  inherited;

  If fPesqPortador(conSimples,
                   Self,
                   edtCodPor,
                   edtDesPor,
                   nil,
                   Key,
                   arrSel,
                   True,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   edtCodEmp.Text)  Then
  Begin
    If fValidaCampos(edtCodPor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
  
end;

procedure TfrmCtrDescontada.edtCodFpgExit(Sender: TObject);
  Var
    arrFpg : TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtCodFpg, edtDesFpg, arrFpg, Nil, fRetDescFpg, 'da Forma de Pagamento');
end;

procedure TfrmCtrDescontada.edtCodFpgKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFpg : TConsultasArray;
begin
  inherited;
  If fPesqFormaPgto(conFpgSimples, Self, edtCodFpg, edtDesFpg, Nil, Key, arrFpg) Then
  Begin
    If fValidaCampos(edtCodFpg, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCtrDescontada.edtCodCidExit(Sender: TObject);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtCodCid, edtNomCid, arrCidade, fRetNomCidadeSemOpc, nil, 'da Cidade',0,False,'Código',True);
end;

procedure TfrmCtrDescontada.edtCodCidKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCidade: TConsultasArray;
    
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, edtCodCid, edtNomCid, Nil, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(edtCodCid, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCtrDescontada.pCalculaTotais;
  Var fltTotGer, fltTotSel, fltQtdTotGer, fltQtdTotSel : Double;
      intRecNo: Integer;
begin
  fltTotGer := 0;
  fltTotSel := 0;
  fltQtdTotGer := 0;
  fltQtdTotSel  := 0;

  If cdsClone.Active Then
  Begin
    With cdsClone Do
    Begin
      intRecNo := RecNo;
      cxgConsultaTableView.BeginUpdate;
      DisableControls;
      First;

      While Not Eof Do
      Begin
        If fInLista(cdsClone.FieldByName('AUTOINCREM').AsString) Then
        begin
          fltTotSel := fltTotSel + FieldByName('CTR_VALDUP').AsFloat;
          fltQtdTotSel := fltQtdTotSel + 1;
        end;

        fltTotGer := fltTotGer + FieldByName('CTR_VALDUP').AsFloat;
        fltQtdTotGer := fltQtdTotGer + 1;

        Next;
      End;
      RecNo := intRecNo;
      cxgConsultaTableView.EndUpdate;
      EnableControls;
    End;
  End;

  edtTotGer.Text := FormatFloat('#,##0.00', fltTotGer);
  edtTotSel.Text := FormatFloat('#,##0.00', fltTotSel);
  edtQtdTotGer.Text := FormatFloat('#0', fltQtdTotGer);
  edtQtdTotSel.Text := FormatFloat('#0', fltQtdTotSel);
end;

procedure TfrmCtrDescontada.dbgConsultaDblClick(Sender: TObject);
begin
  inherited;

  pCalculaTotais;
end;

procedure TfrmCtrDescontada.dbgConsultaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
    pCalculaTotais;
end;

procedure TfrmCtrDescontada.edtCodRegExit(Sender: TObject);
Var
  arrRegiao : TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtCodReg, edtDesReg, arrRegiao, nil, fRetNomRegiao, 'da Região',0,False,'Código',True);
end;

procedure TfrmCtrDescontada.edtCodRegKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrRegiao : TConsultasArray;

begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE REGIOES *}
  {*************************DP*}
  If fPesqRegiao(Self, edtCodReg, edtDesReg, Nil, Key, arrRegiao) Then
  Begin
    if fValidaCampos(edtCodReg, True) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCtrDescontada.edtCodvenExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodven, edtNomVen, arrVend, fRetNomVendRep, nil, 'do Vendedor');
end;

procedure TfrmCtrDescontada.edtCodvenKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodven, edtNomVen, nil, Key, arrVend, False) Then
  Begin
    If fValidaCampos(edtCodven, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCtrDescontada.pCarregaCentroCusto;
begin
  fraPlanoDeContas.edtDesCta.Text := '';
  If not fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
  begin
    pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text);
    With qryConCta Do
    Begin
      fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
    End;
  end;
end;

function TfrmCtrDescontada.fDesmarcarTodas(pgbStatus: TcxProgressBar): Boolean;
var
  LRecNo: Integer;
begin
  Result := True;
  If (cdsConsulta.Active) and (cdsConsulta.RecordCount > 0) Then
  Begin
    With cdsConsulta Do
    Begin
      cxgConsultaTableView.BeginUpdate;
      DisableControls;
      LRecNo := RecNo;
      First;
      While Not Eof Do
      Begin
        pProgresso(RecNo, RecordCount, pgbStatus);
        pAddListaQuery;
        Next;
      End;
      RecNo := LRecNo;
      cxgConsultaTableView.EndUpdate;
      stlListSelecao.Clear;
      EnableControls;
    End;

    pCalculaTotais;
//    dbgConsulta.Refresh;
  End
  else
  begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos uma duplicata!', ['&OK']);
  end;
end;


end.
