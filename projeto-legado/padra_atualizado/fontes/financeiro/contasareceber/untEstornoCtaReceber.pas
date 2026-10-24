{***************************}
{* qryConEmp -> CADEMP     *}
{* qryConCli -> CADCLI     *}
{************************JB*}
unit untEstornoCtaReceber;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  EditFocus, Grids, DBGridCitel, DBGrids, DB, StrUtils, Menus, Uni, AppEvnts, untCadChq,
    UniDataSetProvider, UniClientDataSet, BitBtnLockedIncrem;

type
  TfrmEstornoCtaReceber = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    edtNumDup: TEditFocus;
    Label5: TLabel;
    Label1: TLabel;
    edtCodEmp: TEditFocus;
    Label2: TLabel;
    edtEspDoc: TEditFocus;
    Label3: TLabel;
    edtCodCli: TEditFocus;
    pnlDados: TPanel;
    dbgDuplicatas: TDBGridCitel;
    edtParcel: TEditFocus;
    pnlBotoesEstorno: TPanel;
    btnConfirma: TBitBtnLocked;
    btnSairEst: TBitBtnLocked;
    edtNomCli: TEditFocus;
    edtNomEmp: TEditFocus;
    dtsDados: TDataSource;
    cdsDados: TUniClientDataSet;
    cpvDados: TUniDataSetProvider;
    qryDados: TUniQuery;
    procedure FormCreate(Sender: TObject);
    procedure dbgDuplicatasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgDuplicatasDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnSairEstClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }

    intConfirma: Integer;
    qryConEmp: TUniQuery;
    qryConCli: TUniQuery;

    fltTotGua,
    fltTotDol,
    fltTotEur,
    fltTotPes,
    fltTotRea: Double;

    intPrimSeqBai  : Integer;
    strTabelaMovBan: String;

    strDocsNaoEnc: String;
    blnFecharForm: Boolean;
    stlConjugadas: TStringList;

    intSeqConEstorno: Integer;
    strCodEmpEstorno: String;
    strOpeBaiEstorno: String;
    dtaDtaBaiEstorno: TDateTime;

    procedure pLimpaCampos;
    procedure pCarregaEmpresa;
    procedure pCarregaCliente;
    procedure pCriaTemporaria;
    procedure pCriaTemporariaConjug(strNumDup, strParcel, strCodEmp, strEspDoc, strCodCli: String;
      intSeqBai: Integer);

    procedure pApagaDuplicata(strNumDup, strParcel, strCodEmp, strEspDoc, strCodCli, strNomTab: String;
      intSeqBai: Integer);
      
    procedure pMarcaDuplicata(strMarDes: String);
    procedure pSelecionaDuplicata;
    procedure pConfirmaEstorno;
    procedure pConfirmaEstornoInterno;

    Procedure pEstornaDuplicataSimples(blnConjugadas: Boolean; strPorBai: String = '');
    Procedure pEstornaDuplicataParcial(blnConjugadas: Boolean; strPorBai: String = '');

    procedure pEstornaDuplicataConjugadas(strCodSeq, strEmpRcx: String;
      intResCai: Integer; dtaDtaRec: TDateTime; strOpeBai: String; strPorBai: String = '');

    procedure pDeterminaModalidadeEstorno(strNumDup, strParcel, strEspDoc,
      strCodCli, strCodEmp: String; intSeqBai: Integer; fltValDup: Double;
      Var fltValDin, fltValCar, fltChqVis, fltChqPre, fltOrdRec, fltValFin: Double;
      Var strDocCre, strSeqCon, strEmpRcx: String);

    function fCarregaCartoesTransferidos(intSeqCon: Integer; strEmpRcx: String): TUniQuery;
    function fCarregaChequesTransferidos(intSeqCon: Integer; strEmpRcx: String): TUniQuery;

    Function fHouveTransferenciaCartao(intSeqCon: Integer; strEmpRcx: String): Boolean;
    Function fHouveTransferenciaCheque(intSeqCon: Integer; strEmpRcx: String): Boolean;
    function fEstornaMovCar(strNumDup, strEspDoc, strParcel, strCodEmp: String;
      intSeqBai: Integer): Boolean; overload;
    Function fEstornaMovCar(intSeqCon: Integer; strEmpRcx: String): Boolean; overload;

    function fEstornaCheque(intSeqCon: Integer;
      strEmpRcx, strTipChq: String): Boolean; overload;
    function fEstornaCheque(strNumDup, strEspDoc, strParcel, strCodEmp: String): Boolean; overload;

    function fVerificaDuplicataPrincipal: Boolean;

    function fRetDuplicatasSelecionadas: Integer;

    function fVerSeqBai(strNumDup, strEspDoc, strParcel, strCodEmp, strCodCli: String): Boolean;

    procedure pVerifQtdDuplicatas(strNumDup, strEspDoc, strParcel, strCodEmp,
      strCodCli: String; intSeqBai: Integer; Var strQtdDup, strSeqCon, strEmpRcx: String;
      intResCai: Integer);
    function fChamaTelaConjugadas(strSeqCon, strEmpRcx: String; intResCai: Integer): Boolean;

    function fVerificaDocumentosBaixados(strSeqCon, strEmpRcx: String): Boolean;

    Function fPedePortador(Var strPorBai: String): Boolean;

    procedure pApagaChequeCartao(strSeqCon, strEmpRcx: String; fltValCar,
      fltChqVis, fltChqPre: Double);

    procedure pEstornarLancamentoCreditoCaixa(strNumDup, strParcel, strCodEmp,
      strEspDoc, strCodCli: String; intSeqBai: Integer;
      qryDuplicatas: TUniQuery; strPorBaiSelecionado: String);

    function fVerificaDatasDiferentes(strSeqCon, strEmpRcx: String): Boolean;
    function fVerConfirmada(strNumDup, strEspDoc, strParcel, strCodEmp,
      strCodCli: String): Boolean;

    procedure pRealizaLCDocumentosTransferidos;
    function fLancaLCTransferidos(fltTotalChqVis, fltTotalChqPre,
      fltTotalCartao: Double; strHistorico: String): Boolean;
    procedure pLogChq(qryLog: TUniQuery; strTabela: String; Var arrLogChq: TRegistroLogChq);
    procedure pCarregaValoresParaguai(intSeqcon: Integer; strEmpBai: String);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnResCai : Boolean;
    dtaDtaRcx : TDateTime;
    strSeqCon : String;
  end;

var
  frmEstornoCtaReceber: TfrmEstornoCtaReceber;

implementation

uses untFuncoes, untfuncoesSimples, untPesqAux, untConsultas, untConsultaComp,
  untEstDuplicatasConjug, untConstantes,
  untFinDocsBaixados, untDigPortador, untFuncoesConsulta, untMovBan, untCadRec,
  untCadRcxx, untFuncFat, untBaixaReceber;

{$R *.dfm}

{ TfrmEstornoCtaReceber }

function TfrmEstornoCtaReceber.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O NÚMERO DA DUPLICATA          *}
    {**************************************MV*}
    If (Sender = edtNumDup) Then
    Begin
      If fEmptyStr(edtNumDup.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Número da Duplicata deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DA EMPRESA            *}
    {**************************************MV*}
    Else If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Empresa deve ser preenchido!', ['&O k']);
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
          If qryConEmp.FieldByName('EMP_CODEMP').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&O k']);
            Result := False;
          End;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA A ESPÉCIE                      *}
    {**************************************MV*}
    Else If (Sender = edtEspDoc) Then
    Begin
      If fEmptyStr(edtEspDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Espécie deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If Length(edtEspDoc.Text) <> 2 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Espécie deve ter exatamente 2 caracteres!', ['&O k']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DO CLIENTE            *}
    {**************************************MV*}
    Else If (Sender = edtCodCli) Then
    Begin
      If fEmptyStr(edtCodCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Cliente deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaCliente;
        If qryConCli.FieldByName('CLI_CODCLI').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Cliente não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If blnBuscaPorChave Then
        Begin
          pConfirmaEstorno;
        End;
      End;
    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmEstornoCtaReceber.pCarregaCliente;
begin
  pPesquisaCadCli(qryConCli, qryConCli, edtCodCli.Text);
  With qryConCli Do
  Begin
    edtNomCli.Text := FieldByName('CLI_NOMCLI').AsString;
  End;
end;

procedure TfrmEstornoCtaReceber.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  With qryConEmp Do
  Begin
    edtNomEmp.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;

{*****************************************}
{* CHAMA TELA DE ESTORNO                 *}
{**************************************MV*}
procedure TfrmEstornoCtaReceber.pConfirmaEstorno;
Begin

  If InterlockedIncrement(intConfirma) = 0 Then
  Begin

    Try
      pConfirmaEstornoInterno;
      InterlockedDecrement(intConfirma);
    Except
      On E: Exception Do
      Begin
        InterlockedDecrement(intConfirma);
        pMensagensErro(E.Message, 'TfrmEstornoCtaReceber.pConfirmaEstorno');
      End;
    End;

  End
  Else
    InterlockedDecrement(intConfirma);

End;

procedure TfrmEstornoCtaReceber.pConfirmaEstornoInterno;
Var
  strQtdDup: String;
  strEmpRcx: String;
  strPorBai: String;
  blnDocumentosOk: Boolean;
begin
  If Not fVerificaCampos Then
  Begin
    blnMudarFoco := False;
    Exit;
  End;

  pCriaTemporaria;

  intPrimSeqBai := cdsDados.FieldByName('CTR_SEQBAI').AsInteger;

  If cdsDados.RecordCount = 0 Then
  Begin
    fMensagem('', 'Não há duplicatas a serem estornadas' + IIF(blnResCai,' ou não foi baixada pelo resumo de caixa!', '!'), ['&O k']);

    pSetFocus(edtNumDup);
    pLimpaCampos;
    blnMudarFoco := False;
  End

  Else If (blnResCai) And
          (cdsDados.FieldByName('CTR_DTAREC').AsDateTime <> VS_Date) Then
  Begin
    fMensagem('', 'Estorno não permitido, o resumo de caixa somente estorna a duplicata quando a data de recebimento for a mesma do dia.' + #13#10 +
                  'Por favor, estornar pelo financeiro.', ['&Ok']);
    Exit;
  End

  Else If (cdsDados.RecordCount = 1) And (cdsDados.FieldByName('CTR_SEQBAI').AsInteger = 0) Then
  Begin
    If cdsDados.FieldByName('CTR_EMPBAI').AsString <> VS_strCodEmp Then
    Begin
      fMensagem('','Permitido apenas estornar documentos baixados pela empresa ' + VS_strCodEmp + '!', ['&OK']);
      Exit;
    End;

    {*****************************************************************************}
    {* VERIFICA SE A BAIXA FOI REALIZADA PARA UMA UNICA DUPLICATA OU PARA VÁRIAS *}
    {**************************************************************************LU*}
    strQtdDup := '';
    strSeqCon := '';

    fltTotGua := 0;
    fltTotDol := 0;
    fltTotEur := 0;
    fltTotPes := 0;
    fltTotRea := 0;

    If (cdsDados.FieldByName('CTR_RESCAI').AsInteger = 0) Then
    Begin
      strSeqCon := cdsDados.FieldByName('CTR_SEQCON').AsString;
      strEmpRcx := cdsDados.FieldByName('CTR_EMPBAI').AsString;

      If strToIntDef(strSeqCon, 0) = 0 Then
        strSeqCon := '-1';
    End
    Else
    Begin
      If cdsDados.FieldByName('CTR_SEQCON').AsInteger > 0 Then
        pCarregaValoresParaguai(cdsDados.FieldByName('CTR_SEQCON').AsInteger, cdsDados.FieldByName('CTR_EMPBAI').AsString);
    End;

    pVerifQtdDuplicatas(edtNumDup.Text,
                        edtEspDoc.Text,
                        edtParcel.Text,
                        edtCodEmp.Text,
                        edtCodCli.Text,
                        cdsDados.FieldByName('CTR_SEQBAI').AsInteger,
                        strQtdDup,
                        strSeqCon,
                        strEmpRcx,
                        cdsDados.FieldByName('CTR_RESCAI').AsInteger);

    blnDocumentosOk := True;

    If StrToIntDef(strSeqCon, 0) > 0 Then
    Begin
      blnDocumentosOk := fVerificaDocumentosBaixados(strSeqCon, strEmpRcx);
      If blnDocumentosOk Then
        blnDocumentosOk := fVerificaDatasDiferentes(strSeqCon, strEmpRcx);
    End;

    If fHouveTransferenciaCartao(cdsDados.FieldByName('CTR_SEQCON').AsInteger,
                                 cdsDados.FieldByName('CTR_EMPBAI').AsString) Then
    Begin
      blnDocumentosOk := False;
    End;

    If fHouveTransferenciaCheque(cdsDados.FieldByName('CTR_SEQCON').AsInteger,
                                 cdsDados.FieldByName('CTR_EMPBAI').AsString) Then
    Begin
      blnDocumentosOk := False;
    End;

    If blnDocumentosOk Then
    Begin
      If StrToInt(strQtdDup) <= 1 Then
      Begin

        If (fMensagem('', 'Confirma estorno?', ['&Sim', '&Não']) = 1) And
            fPedePortador(strPorBai) Then
          pEstornaDuplicataSimples(False, strPorBai);

      End
      Else
      Begin
        If fChamaTelaConjugadas(strSeqCon, strEmpRcx, cdsDados.FieldByName('CTR_RESCAI').AsInteger) Then
        Begin
          If (fMensagem('', 'Confirma estorno de todas as duplicatas?', ['&Sim', '&Não']) = 1) And
             fPedePortador(strPorBai) Then
          Begin
            pEstornaDuplicataConjugadas(strSeqCon,
                                        strEmpRcx,
                                        cdsDados.FieldByName('CTR_RESCAI').AsInteger,
                                        cdsDados.FieldByName('CTR_DTAREC').AsDateTime,
                                        cdsDados.FieldByName('CTR_OPEBAI').AsString,
                                        strPorBai);
          End
          Else
          Begin
            pLimpaCampos;
          End;
        End
        Else
        Begin
          pLimpaCampos;
        End;

      End;

    End;

    pLimpaCampos;
    blnMudarFoco := False;
    pSetFocus(edtNumDup);
  End
  Else
  Begin
    pSetFocus(dbgDuplicatas);
    blnMudarFoco := False;
  End;
end;

procedure TfrmEstornoCtaReceber.pCriaTemporaria;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CTR_NUMDUP AS NUMDUP, ';
  strSQL := strSQL + '  CTR_PARCEL AS PARDUP, ';
  strSQL := strSQL + '  CONCAT(CTR_NUMDUP, CTR_PARCEL) AS CTR_NUMDUP, ';
  strSQL := strSQL + '  CTR_CODDIG, ';
  strSQL := strSQL + '  CTR_SEQBAI, ';
  strSQL := strSQL + '  CTR_DTACAD, ';
  strSQL := strSQL + '  CTR_DTAVEN, ';
  strSQL := strSQL + '  CTR_DESCOB, ';
  strSQL := strSQL + '  CTR_DESCON, ';
  strSQL := strSQL + '  CTR_HIST01, ';
  strSQL := strSQL + '  CTR_HIST02, ';
  strSQL := strSQL + '  CTR_EMPBAI, ';
  strSQL := strSQL + '  CTR_CTABAI, ';
  strSQL := strSQL + '  CTR_OPEBAI, ';
  strSQL := strSQL + '  CTR_PORBAI, ';
  strSQL := strSQL + '  CTR_CODEMP, ';
  strSQL := strSQL + '  CTR_ESPDOC, ';
  strSQL := strSQL + '  CTR_CODCLI, ';
  strSQL := strSQL + '  CTR_VALJUR, ';
  strSQL := strSQL + '  CTR_VALDES, ';
  strSQL := strSQL + '  CTR_DTAREC, ';
  strSQL := strSQL + '  CTR_VALREC, ';
  strSQL := strSQL + '  CTR_CODEVE, ';
  strSQL := strSQL + '  CTR_RESCAI, ';
  strSQL := strSQL + '  CTR_ORIF11, ';
  strSQL := strSQL + '  CTR_SEQCON, ';
  strSQL := strSQL + '  CTR_DINHEI, ';
  strSQL := strSQL + '  CTR_CHQAVI, ';
  strSQL := strSQL + '  CTR_CHQPRE, ';
  strSQL := strSQL + '  CTR_CARTAO, ';
  strSQL := strSQL + '  CTR_ORDPAG, ';
  strSQL := strSQL + QuotedStr(strNomeTabela) + ' AS CTR_TABELA, ';
  strSQL := strSQL + '  "D" AS CTR_MARDES, ';
  strSQL := strSQL + '  CTR_VALANT, ';
  strSQL := strSQL + '  CTR_JURANT, ';
  strSQL := strSQL + '  CTR_DESANT, ';
  strSQL := strSQL + '  CTR_VALFIN, ';
  strSQL := strSQL + '  CTR_DTABAI ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + strNomeTabela;
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   CTR_DTAREC IS NOT NULL ';

  strSQL := strSQL + IIF(fEmptyStr(edtNumDup.Text), '', ' AND CTR_NUMDUP = :NUMDUP ');
  strSQL := strSQL + IIF(fEmptyStr(edtParcel.Text), '', ' AND CTR_PARCEL = :PARCEL ');
  strSQL := strSQL + IIF(fEmptyStr(edtCodEmp.Text), '', ' AND CTR_CODEMP = :CODEMP ');
  strSQL := strSQL + IIF(fEmptyStr(edtEspDoc.Text), '', ' AND CTR_ESPDOC = :ESPDOC ');
  strSQL := strSQL + IIF(fEmptyStr(edtCodCli.Text), '', ' AND CTR_CODCLI = :CODCLI ');

  If blnResCai Then
    strSQL := strSQL + ' AND CTR_RESCAI = 1 ';

  strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(strSQL, strNomeTabela, IIF(strNomeTabela = 'CADREC', 'CADRECX', 'CADREC'));

  With qryDados Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If Not fEmptyStr(edtNumDup.Text) Then ParamByName('NUMDUP').AsString := edtNumDup.Text;
    If Not fEmptyStr(edtParcel.Text) Then ParamByName('PARCEL').AsString := edtParcel.Text;
    If Not fEmptyStr(edtCodEmp.Text) Then ParamByName('CODEMP').AsString := edtCodEmp.Text;
    If Not fEmptyStr(edtEspDoc.Text) Then ParamByName('ESPDOC').AsString := edtEspDoc.Text;
    If Not fEmptyStr(edtCodCli.Text) Then ParamByName('CODCLI').AsString := edtCodCli.Text;

    Open;

    pSetaClient(qryDados);

    cdsDados.Close;
    cdsDados.SetProvider(cpvDados);
    cdsDados.Open;

    intSeqConEstorno := -1;
    strCodEmpEstorno := '';
    strOpeBaiEstorno := '';
    dtaDtaBaiEstorno := 0;
    cdsDados.First;
    While (Not cdsDados.Eof) Do
    Begin
      If Not fEmptyStr(cdsDados.FieldByName('CTR_SEQCON').AsString) Then
      Begin
        intSeqConEstorno := cdsDados.FieldByName('CTR_SEQCON').AsInteger;
        strCodEmpEstorno := cdsDados.FieldByName('CTR_EMPBAI').AsString;
        strOpeBaiEstorno := cdsDados.FieldByName('CTR_OPEBAI').AsString;
        dtaDtaBaiEstorno := cdsDados.FieldByName('CTR_DTABAI').AsDateTime;
      End;

      cdsDados.Next;
    End;
    cdsDados.First;

    (cdsDados.FieldByName('CTR_VALREC') As TFloatField).DisplayFormat := '#,##0.00';
  End;

end;

procedure TfrmEstornoCtaReceber.pCriaTemporariaConjug(strNumDup, strParcel, strCodEmp, strEspDoc, strCodCli: String;
  intSeqBai: Integer);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CTR_NUMDUP AS NUMDUP, ';
  strSQL := strSQL + '  CTR_PARCEL AS PARDUP, ';
  strSQL := strSQL + '  CONCAT(CTR_NUMDUP, CTR_PARCEL) AS CTR_NUMDUP, ';
  strSQL := strSQL + '  CTR_CODDIG, ';
  strSQL := strSQL + '  CTR_SEQBAI, ';
  strSQL := strSQL + '  CTR_DTACAD, ';
  strSQL := strSQL + '  CTR_DTAVEN, ';
  strSQL := strSQL + '  CTR_DESCOB, ';
  strSQL := strSQL + '  CTR_DESCON, ';
  strSQL := strSQL + '  CTR_HIST01, ';
  strSQL := strSQL + '  CTR_HIST02, ';
  strSQL := strSQL + '  CTR_EMPBAI, ';
  strSQL := strSQL + '  CTR_CTABAI, ';
  strSQL := strSQL + '  CTR_OPEBAI, ';
  strSQL := strSQL + '  CTR_PORBAI, ';
  strSQL := strSQL + '  CTR_CODEMP, ';
  strSQL := strSQL + '  CTR_ESPDOC, ';
  strSQL := strSQL + '  CTR_CODCLI, ';
  strSQL := strSQL + '  CTR_VALJUR, ';
  strSQL := strSQL + '  CTR_VALDES, ';
  strSQL := strSQL + '  CTR_DTAREC, ';
  strSQL := strSQL + '  CTR_VALREC, ';
  strSQL := strSQL + '  CTR_CODEVE, ';
  strSQL := strSQL + '  CTR_RESCAI, ';
  strSQL := strSQL + '  CTR_ORIF11, ';
  strSQL := strSQL + '  CTR_SEQCON, ';
  strSQL := strSQL + '  CTR_DINHEI, ';
  strSQL := strSQL + '  CTR_CHQAVI, ';
  strSQL := strSQL + '  CTR_CHQPRE, ';
  strSQL := strSQL + '  CTR_CARTAO, ';
  strSQL := strSQL + '  CTR_ORDPAG, ';
  strSQL := strSQL + QuotedStr(strNomeTabela) + ' AS CTR_TABELA, ';
  strSQL := strSQL + '  "M" AS CTR_MARDES, ';
  strSQL := strSQL + '  CTR_VALANT, ';
  strSQL := strSQL + '  CTR_JURANT, ';
  strSQL := strSQL + '  CTR_DESANT  ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + strNomeTabela;
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   CTR_DTAREC IS NOT NULL ';

  strSQL := strSQL + IIF(fEmptyStr(strNumDup), '', ' AND CTR_NUMDUP = :NUMDUP ');
  strSQL := strSQL + IIF(fEmptyStr(strParcel), '', ' AND CTR_PARCEL = :PARCEL ');
  strSQL := strSQL + IIF(fEmptyStr(strCodEmp), '', ' AND CTR_CODEMP = :CODEMP ');
  strSQL := strSQL + IIF(fEmptyStr(strEspDoc), '', ' AND CTR_ESPDOC = :ESPDOC ');
  strSQL := strSQL + IIF(fEmptyStr(strCodCli), '', ' AND CTR_CODCLI = :CODCLI ');
  strSQL := strSQL + IIF(fEmptyStr(strNumDup), '', ' AND CTR_SEQBAI = :SEQBAI ');

  If blnResCai Then
    strSQL := strSQL + ' AND CTR_RESCAI = 1 ';

  strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(strSQL, strNomeTabela, IIF(strNomeTabela = 'CADREC', 'CADRECX', 'CADREC'));

  With qryDados Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If Not fEmptyStr(strNumDup) Then ParamByName('NUMDUP').AsString  := strNumDup;
    If Not fEmptyStr(strParcel) Then ParamByName('PARCEL').AsString  := strParcel;
    If Not fEmptyStr(strCodEmp) Then ParamByName('CODEMP').AsString  := strCodEmp;
    If Not fEmptyStr(strEspDoc) Then ParamByName('ESPDOC').AsString  := strEspDoc;
    If Not fEmptyStr(strCodCli) Then ParamByName('CODCLI').AsString  := strCodCli;
    If Not fEmptyStr(strNumDup) Then ParamByName('SEQBAI').AsInteger := intSeqBai;

    Open;

    pSetaClient(qryDados);

    cdsDados.Close;
    cdsDados.SetProvider(cpvDados);
    cdsDados.Open;

    (cdsDados.FieldByName('CTR_VALREC') As TFloatField).DisplayFormat := '#,##0.00';
  End;

end;

{*****************************************}
{* USADO QUANDO UMA DUPLICATA NÃO POSSUI *}
{* BAIXAS PARCIAIS                       *}
{**************************************MV*}
Procedure TfrmEstornoCtaReceber.pEstornaDuplicataSimples(blnConjugadas: Boolean; strPorBai: String);
  Var
    strSQL       : String;
    fltNovoValOri: Double;
    strCreDeb    : String;
    fltValLan    : Double;
    qryGen       : TUniQuery;

    fltValDin    : Double;
    fltValCar    : Double;
    fltChqVis    : Double;
    fltChqPre    : Double;
    fltOrdRec    : Double;
    fltValFin    : Double;
    strDocCre    : String;
    strMensagem  : String;
    arrLogCtr    : TRegistroLogCtr;
    strSeqCon    : String;
    strEmpRcx    : String;
    strSeqRcx    : String;
    dtaEstorn    : TDateTime;
begin
  strSeqCon := '';
  strEmpRcx := '';
  dtaEstorn := 0;

  Try
    If Not blnConjugadas Then
      fStartTransaction;

    qryGen := fCriaQuery;
    SetLength(arrLogCtr,0);

    fltNovoValOri := cdsDados.FieldByName('CTR_VALREC').AsFloat -
                     cdsDados.FieldByName('CTR_VALJUR').AsFloat +
                     cdsDados.FieldByName('CTR_VALDES').AsFloat;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + cdsDados.FieldByName('CTR_TABELA').AsString + ' ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  CTR_VALORI = :VALORI, ';
    strSQL := strSQL + '  CTR_VALDUP = :VALORI, ';
    strSQL := strSQL + '  CTR_VALJUR = 0, ';
    strSQL := strSQL + '  CTR_VALDES = 0, ';
    strSQL := strSQL + '  CTR_VALREC = 0, ';
    strSQL := strSQL + '  CTR_DTABAI = NULL, ';
    strSQL := strSQL + '  CTR_DTAREC = NULL, ';
    strSQL := strSQL + '  CTR_PORBAI = NULL, ';
    strSQL := strSQL + '  CTR_HISBAI = NULL, ';
    strSQL := strSQL + '  CTR_DOCBAI = NULL, ';
    strSQL := strSQL + '  CTR_EMPBAI = NULL, ';
    strSQL := strSQL + '  CTR_CTABAI = NULL, ';
    strSQL := strSQL + '  CTR_OPEBAI = NULL, ';
    strSQL := strSQL + '  CTR_RESCAI = 0,    ';
    strSQL := strSQL + '  CTR_ORIF11 = "N",  ';
    strSQL := strSQL + '  CTR_SEQCON = 0     ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  CTR_SEQBAI = 0 ';

    If blnResCai Then
      strSQL := strSQL + '  AND CTR_RESCAI = 1 ';

    {*******************************************}
    {* CARREGA DADOS                           *}
    {****************************************AF*}
    If cdsDados.FieldByName('CTR_VALREC').AsFloat > 0 Then
    Begin
      fltValLan := cdsDados.FieldByName('CTR_VALREC').AsFloat;
      strCreDeb := 'D';
    End
    Else
    Begin
      fltValLan := -cdsDados.FieldByName('CTR_VALREC').AsFloat; // Inverto o valor
      strCreDeb := 'C';
    End;

    If (Not blnConjugadas) Then
    Begin

      If cdsDados.FieldByName('CTR_RESCAI').AsInteger = 1 Then
      Begin
        pDeterminaModalidadeEstorno(cdsDados.FieldByName('NUMDUP').AsString,
                                    cdsDados.FieldByName('PARDUP').AsString,
                                    cdsDados.FieldByName('CTR_ESPDOC').AsString,
                                    cdsDados.FieldByName('CTR_CODCLI').AsString,
                                    cdsDados.FieldByName('CTR_CODEMP').AsString,
                                    cdsDados.FieldByName('CTR_SEQBAI').AsInteger,
                                    fltValLan,
                                    fltValDin,
                                    fltValCar,
                                    fltChqVis,
                                    fltChqPre,
                                    fltOrdRec,
                                    fltValFin,
                                    strDocCre,
                                    strSeqCon,
                                    strEmpRcx);
      End
      Else
      Begin
        fltValDin := cdsDados.FieldByName('CTR_DINHEI').AsFloat;
        fltValCar := cdsDados.FieldByName('CTR_CARTAO').AsFloat;
        fltChqVis := cdsDados.FieldByName('CTR_CHQAVI').AsFloat;
        fltChqPre := cdsDados.FieldByName('CTR_CHQPRE').AsFloat;
        fltOrdRec := cdsDados.FieldByName('CTR_ORDPAG').AsFloat;
        fltValFin := cdsDados.FieldByName('CTR_VALFIN').AsFloat;
      End;
    End;

    If fCfgSisL('DTAOER') = '1' Then
      dtaEstorn := VS_Date
    Else
      dtaEstorn := cdsDados.FieldByName('CTR_DTAREC').AsDateTime;    

    If (cdsDados.FieldByName('CTR_RESCAI').AsInteger = 0        ) Or
       ((cdsDados.FieldByName('CTR_ORIF11').AsString = 'S') And (cdsDados.FieldByName('CTR_RESCAI').AsInteger = 0)) Or
       ((cdsDados.FieldByName('CTR_DTAREC').AsDateTime <> dtaDtaRcx) And
        (cdsDados.FieldByName('CTR_RESCAI').AsInteger  <> 0      )) Then
    Begin
      {*****************************************}
      {* GRAVA MOVBAN                          *}
      {**************************************MV*}
      If fEmptyStr(fGravaMovBan(IIF(cdsDados.FieldByName('CTR_TABELA').AsString = 'CADREC', 'MOVBAN', 'MOVBANX'),
                                cdsDados.FieldByName('CTR_CTABAI').AsString,                  // Centro de Custo
                                IIF(fEmptyStr(cdsDados.FieldByName('CTR_PORBAI').AsString),
                                    strPorBai, cdsDados.FieldByName('CTR_PORBAI').AsString),  // Portador da Baixa
                                strLoginUsuarioLogado,                                        // Operador da Baixa
                                dtaEstorn{VS_Date},                                           // Data do Lançamento
                                Time,                                                         // Hora do Lançamento
                                cdsDados.FieldByName('CTR_NUMDUP').AsString,                           // Numero do Documento
                                strCreDeb,                                                    // Credito / Debito
                                cdsDados.FieldByName('CTR_CODEMP').AsString,                           // Empresa da Baixa
                                fltValLan,                                                    // Valor Do Lançamento
                                'ESTORNO DA DUPLICATA ' + cdsDados.FieldByName('CTR_NUMDUP').AsString, // Histórico 1
                                '',                                                           // Histórico 2
                                cdsDados.FieldByName('CTR_CODCLI').AsString,                           // Cliente da Duplicata
                                '',                                                           // Fornecedor da Duplicata
                                cdsDados.FieldByName('NUMDUP').AsString,                               // Número da Duplicata
                                0,                                                            // Sequencial de Baixa
                                cdsDados.FieldByName('PARDUP').AsString,                               // Parcela da Duplicata
                                VS_strCodEmp,                                                 // Empresa da Duplicata
                                '',                                                           // Serie
                                cdsDados.FieldByName('CTR_CODEVE').AsString,                           // Codigo do Evento
                                '')) Then
      Begin
        fMensagem('', 'Não foi possível gravar o movimento bancário!', ['&Ok']);
        Exit;
      End;
    End;

    {*****************************************}
    {* ESTORNA A DUPLICATA                   *}
    {**************************************MV*}
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('VALORI').AsFloat := fltNovoValOri;
      ParamByName('NUMDUP').AsString := cdsDados.FieldByName('NUMDUP').AsString;
      ParamByName('PARCEL').AsString := cdsDados.FieldByName('PARDUP').AsString;
      ParamByName('ESPDOC').AsString := cdsDados.FieldByName('CTR_ESPDOC').AsString;
      ParamByName('CODEMP').AsString := cdsDados.FieldByName('CTR_CODEMP').AsString;
      ParamByName('CODCLI').AsString := cdsDados.FieldByName('CTR_CODCLI').AsString;
      ExecSQL;
      Close;
    End;

    With cdsDados Do
    Begin
      fInsereLogCtrArr(arrLogCtr,
                       FieldByName('NUMDUP').AsString,
                       FieldByName('PARDUP').AsString,
                       0,
                       FieldByName('CTR_ESPDOC').AsString,
                       FIeldByName('CTR_CODCLI').AsString,
                       FieldByName('CTR_CODEMP').AsString,
                       strLoginUsuarioLogado,
                       strLoginUsuarioLogado,
                       '',
                       FieldByName('CTR_DTACAD').AsDateTime,
                       FieldByName('CTR_DTAVEN').AsDateTime,
                       FieldByName('CTR_VALREC').AsFloat,
                       FieldByName('CTR_VALREC').AsFloat,
                       FieldByName('CTR_DESCOB').AsFloat,
                       FieldByName('CTR_DESCON').AsString,
                       FieldByName('CTR_HIST01').AsString,
                       FieldByName('CTR_HIST02').AsString,
                       '',
                       '',
                       '',
                       '',
                       '',
                       0.0,
                       0,
                       0,
                       '',
                       '',
                       'ESTORNO',
                       Self.Name + IIF(blnResCai, 'RESCAI',''),
                       0,
                       0.0,
                       0.0,
                       0.0,
                       0.0,
                       0.0,
                       0.0,
                       0.0,
                       0.0,
                       False,
                       False,
                       False,
                       False,
                       False,
                       False,
                       0,
                       '',
                       '',
                       False,
                       '',
                       0);

      If Length(arrLogCtr) > 0 Then
      Begin
        If Not fGravaLogCtr(arrLogCtr) Then
          Raise Exception.Create('Ocorreu um erro!');
      End;

      If (Not blnConjugadas) Then
      Begin
        If (FieldByName('CTR_RESCAI').AsInteger <> 0      ) And
           (FieldByName('CTR_DTAREC').AsDateTime = dtaDtaRcx) Then
        Begin
          fGravaCadRcx(strSeqRcx,                                                       //AUTOINCREM
                       FieldByName('CTR_CODCLI').AsString,                              // Cliente
                       FieldByName('CTR_OPEBAI').AsString,                              // Operador
                       FieldByName('CTR_NUMDUP').AsString,                              // Documento
                       IIF(strCreDeb = 'D', 'LD', 'LC'),                                // Espécie
                       VS_strCodEmp,                                                    // Empresa
                       dtaDtaRcx,                                                         // Data de Cadastro
                       Time,                                                            // Hora de Cadastro
                       FieldByName('NUMDUP').AsString,                                  // Duplicata
                       FieldByName('PARDUP').AsString,                                  // Parcela
                       'REF. A ESTORNO. CTA. RECEBER',                                  // Descrição
                       '',                                                              // Juros / Desconto
                       '',                                                              // Identificação de Fechamento
                       '',                                                              // Forma de Pagamento
                       IIF(strCreDeb = 'D', -1, 1) * fltValLan,                         // Valor do Documento
                       0.0,                                                             // Valor do Desconto
                       0.0,                                                             // Valor do Juros
                       IIF(strCreDeb = 'D', -1, IIF(fltValDin < 0, -1, 1)) * fltValDin, // Dinheiro recebido
                       IIF(strCreDeb = 'D', -1, IIF(fltChqVis < 0, -1, 1)) * fltChqVis, // Cheque a vista
                       IIF(strCreDeb = 'D', -1, IIF(fltChqPre < 0, -1, 1)) * fltChqPre, // Cheque pre datado
                       IIF(strCreDeb = 'D', -1, IIF(fltValCar < 0, -1, 1)) * fltValCar, // Valor em Cartã
                       IIF(strCreDeb = 'D', -1, IIF(fltOrdRec < 0, -1, 1)) * fltOrdRec, // Valor em Ordem de Pagamento
                       0.0,                                                             // Valor do Crédito
                       IIF(strCreDeb = 'D', -1, IIF(fltValFin < 0, -1, 1)) * fltValFin, // Valor em Financiamento
                       0.0,                                                             // Valor de outros
                       0.0,                                                             // Venda a prazo
                       '',                                                              // Num. do Romaneio
                       StrToInt(fRetRcxCon),                                            // Sequencial de Controle
                       FieldByName('CTR_SEQBAI').AsInteger,                             // Sequencial de Baixa (Duplicata)
                       fCfgSisL('SQFCRX'),                                              // Sequencial de Fechamento parcial de caixa
                       FieldByName('CTR_CODEMP').AsString,                              // Empresa da duplicata
                       '',                                                              // MotDes
                       IIF(cdsDados.FieldByName('CTR_TABELA').AsString = 'CADREC', 1, 2), // Identificação do Caixa
                       fltTotGua,
                       fltTotDol,
                       fltTotEur,
                       fltTotPes,
                       fltTotRea);
        End;

        If (Not blnConjugadas) Then
        Begin

          If fEmptyStr(strSeqCon) Then
          Begin
            strSeqCon := FieldByName('CTR_SEQCON').AsString;
            strEmpRcx := FieldByName('CTR_EMPBAI').AsString;
          End;

          If Not blnConjugadas Then
            pRealizaLCDocumentosTransferidos;

          pApagaChequeCartao(strSeqCon,
                             strEmpRcx,
                             fltValCar,
                             fltChqVis,
                             fltChqPre);
        End;

      End;

    End;

    If (Not blnConjugadas) Then
    Begin
      fCommit;

      strMensagem := 'Duplicata estornada com sucesso!';
      If (Not fEmptyStr(strDocCre)) Then
        strMensagem := strMensagem + #13#10 + 'Há um crédito de número (' + strDocCre + '). ' +
                                              'Favor verificar. ';

      If Not fEmptyStr(strDocsNaoEnc) Then
        fMensagem('ATENÇÃO!', 'Não foram encontrados os ' + strDocsNaoEnc + '. Favor verificar.', ['&Ok']);

      fMensagem('', strMensagem, ['&O k']);
      pLimpaCampos;
    End;

    FreeAndNil(qryGen);
  Except
    On E: Exception Do
    Begin
      fRollBack;
      FreeAndNil(qryGen);
      If blnConjugadas Then
        Raise Exception.Create(E.Message)
      Else
        pMensagensErro('Erro ao tentar estornar duplicata:' + #13 + E.Message, '[pEstornaDuplicataSimples]');
    End;
  End;

end;

procedure TfrmEstornoCtaReceber.FormCreate(Sender: TObject);
begin
  inherited;

  If intCaixa = 1 Then
  Begin
    strNomeTabela   := 'CADREC';
    strTabelaMovBan := 'MOVBAN';
  End
  Else
  Begin
    strNomeTabela   := 'CADRECX';
    strTabelaMovBan := 'MOVBANX';
  End;

  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);

  edtCodEmp.Text := VS_strCodEmp;
  pCarregaEmpresa;

  cdsDados.Close;

  blnFecharForm := False;
  intConfirma := -1;
end;

procedure TfrmEstornoCtaReceber.pLimpaCampos;
begin
  edtNomCli.Clear;
  edtNumDup.Clear;
  edtEspDoc.Clear;
  edtCodCli.Clear;

  cdsDados.Close;

  edtParcel.Text := 'A';

  pSetFocus(edtNumDup);
end;

procedure TfrmEstornoCtaReceber.pLogChq(qryLog: TUniQuery; strTabela: String;
  var arrLogChq: TRegistroLogChq);
begin

  With qryLog Do
  Begin
    fInsereLogChqArr(arrLogChq,
                     FieldByName('CHQ_CODBCO').AsString,
                     FieldByName('CHQ_NUMAGE').AsString,
                     FieldByName('CHQ_CONCOR').AsString,
                     FieldByName('CHQ_NUMCHQ').AsString,
                     FieldByName('CHQ_CODCLI').AsString,
                     FieldByName('CHQ_NOMEMI').AsString,
                     FieldByName('CHQ_ENDERE').AsString,
                     FieldByName('CHQ_TELEMI').AsString,
                     FieldByName('CHQ_CGCCPF').AsString,
                     FieldByName('CHQ_C_G_C_').AsString,
                     FieldByName('CHQ_DTACAD').AsDateTime,
                     FieldByName('CHQ_DTAVEN').AsDateTime,
                     FieldByName('CHQ_VALCHQ').AsFloat,
                     FieldByName('CHQ_HIST01').AsString,
                     FieldByName('CHQ_HIST02').AsString,
                     FieldByName('CHQ_CTADEP').AsString,
                     FieldByName('CHQ_DTADEP').AsDateTime,
                     FieldByName('CHQ_DOCDEP').AsString,
                     FieldByName('CHQ_CODPOR').AsString,
                     FieldByName('CHQ_CODCTA').AsString,
                     FieldByName('CHQ_DTADEV').AsDateTime,
                     FieldByName('CHQ_MOTDEV').AsString,
                     FieldByName('CHQ_DTARDP').AsDateTime,
                     FieldByName('CHQ_FORREP').AsString,
                     FieldByName('CHQ_OBSREP').AsString,
                     FieldByName('CHQ_DTAREP').AsDateTime,
                     FieldByName('CHQ_RESCAI').AsInteger,
                     FieldByName('CHQ_CODEMP').AsString,
                     FieldByName('CHQ_NUMNOT').AsString,
                     FieldByName('CHQ_DTACUS').AsDateTime,
                     FieldByName('CHQ_PORCUS').AsString,
                     FieldByName('CHQ_DOCUME').AsString,
                     FieldByName('CHQ_INCCTR').AsString,
                     FieldByName('CHQ_HISTOR').AsString,
                     FieldByName('CHQ_DOCCUS').AsString,
                     FieldByName('CHQ_LOTCUS').AsString,
                     FieldByName('CHQ_PORDEB').AsString,
                     FieldByName('CHQ_CTADEB').AsString,
                     FieldByName('CHQ_MOTDV2').AsString,
                     FieldByName('CHQ_DTADP2').AsDateTime,
                     FieldByName('CHQ_DTADV2').AsDateTime,
                     FieldByName('CHQ_SEQCOM').AsString,
                     FieldByName('CHQ_DTATRA').AsDateTime,
                     FieldByName('CHQ_SEQCON').AsInteger,
                     FieldByName('CHQ_EMPRCX').AsString,
                     'DELETANDO (frmEstornoCtaReceber.pLogChq)',
                     strTabela,
                     FieldByName('CHQ_DEVDEF').AsInteger,
                     FieldByName('CHQ_CODVEN').AsString,
                     FieldByName('CHQ_SEQTRF').AsInteger,
                     FieldByName('CHQ_DUPDEV').AsString,
                     FieldByName('CHQ_DUPDEP').AsString,
                     FieldByName('CHQ_CTDPSV').AsString,
                     FieldByName('CHQ_CTDBSV').AsString,
                     FieldByName('CHQ_PRDBSV').AsString,
                     FieldByName('CHQ_CDCTSV').AsString,
                     FieldByName('CHQ_CDPRSV').AsString,
                     FieldByName('CHQ_TELCHE').AsString,
                     FieldByName('CHQ_TELNUM').AsString,
                     FieldByName('CHQ_SEQDEP').AsString,
                     FieldByName('CHQ_CODOPE').AsString,
                     FieldByName('CHQ_CODCMC').AsString);
  End;

end;

Function TfrmEstornoCtaReceber.fEstornaMovCar(intSeqCon: Integer; strEmpRcx: String): Boolean;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Result := True;

  If intSeqCon <= 0 Then
  Begin
    strDocsNaoEnc := strDocsNaoEnc + 'Cartões';
    Exit;
  End;

  qryGen := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVCAR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  MCA_SEQCON = :SEQCON AND ';
  strSQL := strSQL + '  MCA_EMPRCX = :EMPRCX  ';

  qryGen.Close;
  qryGen.SQL.Clear;
  qryGen.SQL.Add(strSQL);
  qryGen.ParamByName('SEQCON').AsInteger := intSeqCon;
  qryGen.ParamByName('EMPRCX').AsString  := strEmpRcx;
  qryGen.Open;

  If (qryGen.FieldByName('QTD').AsInteger > 0) Then
  Begin

    strSQL := '';
    strSQL := strSQL +  ' DELETE FROM MOVCAR         ';
    strSQL := strSQL +  ' WHERE                      ';
    strSQL := strSQL +  '   MCA_SEQCON = :SEQCON AND ';
    strSQL := strSQL +  '   MCA_EMPRCX = :EMPRCX  ';

    With qryGen, Sql Do
    Begin
      Close;
      Clear;
      Add(strSQL);
      ParamByName('SEQCON').AsInteger := intSeqCon;
      ParamByName('EMPRCX').AsString  := strEmpRcx;
      ExecSQL;
      Close;

      Result := True;
    End;

  End
  Else
    strDocsNaoEnc := strDocsNaoEnc + 'Cartões';

  FreeAndNil(qryGen);
End;

Function TfrmEstornoCtaReceber.fPedePortador(Var strPorBai: String): Boolean;
  Var
    blnPedPor: Boolean;
Begin
  Result := TRUE;
  blnPedPor := FALSE;

  With cdsDados Do
  Begin
    DisableControls;

    First;
    While Not Eof Do
    Begin
      If fEmptyStr(cdsDados.FieldByName('CTR_PORBAI').AsString) Or
         fEmptyStr(fRetNomPortador(cdsDados.FieldByName('CTR_PORBAI').AsString)) Then
      Begin
        blnPedPor := TRUE;
        Break;
      End;
      Next;
    End;

    EnableControls;
  End;

  If blnPedPor Then
  Begin
    fMensagem('', 'Há duplicata(s) com o Portador da baixa em branco!', ['&Ok']);
    pCriarFormularios(TfrmDigPortador, frmDigPortador);
    frmDigPortador.Caption := 'Informe o Portador para o estorno';
    frmDigPortador.ShowModal;
    Result := frmDigPortador.blnConfirma;
    If Result Then
      strPorBai := frmDigPortador.strCodPor;
    FreeAndNil(frmDigPortador);
  End;

End;

procedure TfrmEstornoCtaReceber.pEstornaDuplicataParcial(blnConjugadas: Boolean; strPorBai: String = '');
  Var
    blnSomenteParcial: Boolean;
    fltValLan        : Double;
    fltValorTotal    : Double;
    intFatMult       : Integer;
    intSeqConRcx     : Integer;
    strSeqBai        : String;
    strSQL           : String;
    strCreDeb        : String;
    qryGen           : TUniQuery;

    fltValDin        : Double;
    fltValCar        : Double;
    fltChqVis        : Double;
    fltChqPre        : Double;
    fltOrdRec        : Double;
    fltValFin        : Double;
    strDocCre        : String;
    strMensagem      : String;
    arrLogCtr        : TRegistroLogCtr;

    strSeqCon        : String;
    strEmpRcx        : String;
    fltValAnt        : Double;
    fltJurAnt        : Double;
    fltDesAnt        : Double;
    dtaVenAnt        : TDate;
    strSeqRcx        : String;
    dtaEstorn        : TDateTime;
begin

  Try
    fltValAnt := 0;
    fltJurAnt := 0;
    fltDesAnt := 0;
    dtaVenAnt := 0;
    dtaEstorn := 0;    

    If Not blnConjugadas Then
      fStartTransaction;
      
    qryGen := fCriaQuery;
    SetLength(arrLogCtr,0);
    blnSomenteParcial := False;
    intSeqConRcx      := -1;

    With cdsDados Do
    Begin
      intFatMult    := 1;
      fltValorTotal := 0.0;

      DisableControls;
      First;

      {*****************************************}
      {* CASO TENHA SOMENTE DUPLICATAS BAIXA-  *}
      {* DAS SOMENTE 'PARCIAIS', OU SEJA, A    *}
      {* DUPLICATA PRINCIPAL JÁ FOI ESTORNADA, *}
      {* DEVE-SE SOMAR O VALOR RECEBIDO DAS    *}
      {* DUPLICATAS PARCIAIS AO VALOR ORIGINAL *}
      {* DA DUPLICATA, E NÃO SOBRESCREVER O    *}
      {* MESMO                                 *}
      {**************************************MV*}
      If FieldByName('CTR_SEQBAI').AsInteger > 0 Then
        blnSomenteParcial := True;

      {*****************************************}
      {* PROCESSA AS DUPLICATAS SOMANDO OS     *}
      {* VALORES RECEBIDOS E GUARDANDO OS SE-  *}
      {* QUENCIAIS DE BAIXA QUE SERÃO APAGADOS *}
      {**************************************MV*}
      While Not Eof Do
      Begin

        If FieldByName('CTR_VALREC').AsFloat < 0 Then
          intFatMult := -1;

        If FieldByName('CTR_MARDES').AsString = 'M' Then
        Begin
          fltValLan := (FieldByName('CTR_VALREC').AsFloat -
                        FieldByName('CTR_VALJUR').AsFloat +
                        FieldByName('CTR_VALDES').AsFloat);

          fltValAnt := FieldByName('CTR_VALANT').AsFloat;
          dtaVenAnt := FieldByName('CTR_DTAVEN').AsDateTime;

          fltJurAnt := FieldByName('CTR_JURANT').AsFloat;
          fltDesAnt := FieldByName('CTR_DESANT').AsFloat;

          strCreDeb := IIF(fltValLan > 0, 'D', 'C');
          fltValLan := fltValLan * intFatMult;

          If (Not blnConjugadas) Then
          Begin
            If FieldByName('CTR_RESCAI').AsInteger = 1 Then
            Begin
              pDeterminaModalidadeEstorno(cdsDados.FieldByName('NUMDUP').AsString,
                                          cdsDados.FieldByName('PARDUP').AsString,
                                          cdsDados.FieldByName('CTR_ESPDOC').AsString,
                                          cdsDados.FieldByName('CTR_CODCLI').AsString,
                                          cdsDados.FieldByName('CTR_CODEMP').AsString,
                                          cdsDados.FieldByName('CTR_SEQBAI').AsInteger,
                                          fltValLan,
                                          fltValDin,
                                          fltValCar,
                                          fltChqVis,
                                          fltChqPre,
                                          fltOrdRec,
                                          fltValFin,
                                          strDocCre,
                                          strSeqCon,
                                          strEmpRcx);
            End
            Else
            Begin
              fltValDin := FieldByName('CTR_DINHEI').AsFloat;
              fltValCar := FieldByName('CTR_CARTAO').AsFloat;
              fltChqVis := FieldByName('CTR_CHQAVI').AsFloat;
              fltChqPre := FieldByName('CTR_CHQPRE').AsFloat;
              fltOrdRec := FieldByName('CTR_ORDPAG').AsFloat;
              fltValFin := FieldByName('CTR_VALFIN').AsFloat;
            End;
          End;

          If FieldByName('CTR_SEQBAI').AsInteger > 0 Then
            strSeqBai := strSeqBai + FieldByName('CTR_SEQBAI').AsString + ', ';

          If fCfgSisL('DTAOER') = '1' Then
            dtaEstorn := VS_Date
          Else
            dtaEstorn := FieldByName('CTR_DTAREC').AsDateTime;            

          If (FieldByName('CTR_RESCAI').AsInteger = 0          ) Or
             ((FieldByName('CTR_ORIF11').AsString = 'S') And (FieldByName('CTR_RESCAI').AsInteger = 0)) Or
             ((FieldByName('CTR_DTAREC').AsDateTime <> dtaDtaRcx) And
              (FieldByName('CTR_RESCAI').AsInteger  <> 0      )) Then
          Begin
            {*****************************************}
            {* GRAVA MOVBAN                          *}
            {**************************************MV*}
            If fEmptyStr(fGravaMovBan(IIF(FieldByName('CTR_TABELA').AsString = 'CADREC', 'MOVBAN', 'MOVBANX'),
                                      FieldByName('CTR_CTABAI').AsString,                           // Centro de Custo
                                      IIF(fEmptyStr(FieldByName('CTR_PORBAI').AsString),
                                          strPorBai, FieldByName('CTR_PORBAI').AsString),           // Portador da Baixa
                                      strLoginUsuarioLogado,                                        // Operador da Baixa
                                      dtaEstorn{VS_Date},                                           // Data do Lançamento
                                      Time,                                                         // Hora do Lançamento
                                      FieldByName('CTR_NUMDUP').AsString,                           // Numero do Documento
                                      strCreDeb,                                                    // Credito / Debito
                                      FieldByName('CTR_CODEMP').AsString,                           // Empresa da Baixa
                                      fltValLan,                                                    // Valor Do Lançamento
                                      'ESTORNO DA DUPLICATA ' + FieldByName('CTR_NUMDUP').AsString, // Histórico 1
                                      '',                                                           // Histórico 2
                                       FieldByName('CTR_CODCLI').AsString,                           // Cliente da Duplicata
                                      '',                                                           // Fornecedor da Duplicata
                                      FieldByName('NUMDUP').AsString,                               // Número da Duplicata
                                      0,                                                            // Sequencial de Baixa
                                      FieldByName('PARDUP').AsString,                               // Parcela da Duplicata
                                      VS_strCodEmp,                                                 // Empresa da Duplicata
                                      '',                                                           // Serie
                                      FieldByName('CTR_CODEVE').AsString,                           // Codigo do Evento
                                      '')) Then
            Begin
              fMensagem('', 'Não foi possível gravar o movimento bancário!', ['&Ok']);
              Exit;
            End;
          End;

          If (FieldByName('CTR_RESCAI').AsInteger = 1)        And
             (Not blnConjugadas)                              And
             (FieldByName('CTR_DTAREC').AsDateTime = dtaDtaRcx) Then
          Begin
            If intSeqConRcx < 0 Then
              intSeqConRcx := StrToInt(fRetRcxCon);

            fGravaCadRcx(strSeqRcx,
                         FieldByName('CTR_CODCLI').AsString,      // Cliente
                         FieldByName('CTR_OPEBAI').AsString,      // Operador
                         FieldByName('CTR_NUMDUP').AsString,      // Documento
                         IIF(strCreDeb = 'D', 'LD', 'LC'),        // Espécie
                         VS_strCodEmp,                            // Empresa
                         dtaDtaRcx,                                 // Data de Cadastro
                         Time,                                    // Hora de Cadastro
                         FieldByName('NUMDUP').AsString,          // Duplicata
                         FieldByName('PARDUP').AsString,          // Parcela
                         'REF. A ESTORNO. CTA. RECEBER',          // Descrição
                         '',                                      // Juros / Desconto
                         '',                                      // Identificação de Fechamento
                         '',                                      // Forma de Pagamento
                         IIF(strCreDeb = 'D', -1, 1) * fltValLan, // Valor do Documento
                         0.0,                                     // Valor do Desconto
                         0.0,                                     // Valor do Juros
                         IIF(strCreDeb = 'D', -1, IIF(fltValDin < 0, -1, 1)) * fltValDin, // Dinheiro recebido
                         IIF(strCreDeb = 'D', -1, IIF(fltChqVis < 0, -1, 1)) * fltChqVis, // Cheque a vista
                         IIF(strCreDeb = 'D', -1, IIF(fltChqPre < 0, -1, 1)) * fltChqPre, // Cheque pre datado
                         IIF(strCreDeb = 'D', -1, IIF(fltValCar < 0, -1, 1)) * fltValCar, // Valor em Cartã
                         IIF(strCreDeb = 'D', -1, IIF(fltOrdRec < 0, -1, 1)) * fltOrdRec, // Valor em Ordem de Pagamento
                         0.0,                                     // Valor do Crédito
                         IIF(strCreDeb = 'D', -1, IIF(fltValFin < 0, -1, 1)) * fltValFin, // Valor em Financiamento
                         0.0,                                     // Valor de outros
                         0.0,                                     // Venda a prazo
                         '',                                      // Num. do Romaneio
                         intSeqConRcx,                            // Sequencial de Controle
                         FieldByName('CTR_SEQBAI').AsInteger,     // Sequencial de Baixa (Duplicata)
                         fCfgSisL('SQFCRX'),                      // Sequencial de Fechamento parcial de caixa
                         FieldByName('CTR_CODEMP').AsString,      // Empresa da duplicata
                         '',                                      // MotDes
                         IIF(FieldByName('CTR_TABELA').AsString = 'CADREC', 1, 2), // Identificação do Caixa
                         fltTotGua,
                         fltTotDol,
                         fltTotEur,
                         fltTotPes,
                         fltTotRea);
          End;

          fInsereLogCtrArr(arrLogCtr,
                           FieldByName('NUMDUP').AsString,
                           FieldByName('PARDUP').AsString,
                           0,
                           FieldByName('CTR_ESPDOC').AsString,
                           FIeldByName('CTR_CODCLI').AsString,
                           FieldByName('CTR_CODEMP').AsString,
                           strLoginUsuarioLogado,
                           strLoginUsuarioLogado,
                           '',
                           FieldByName('CTR_DTACAD').AsDateTime,
                           FieldByName('CTR_DTAVEN').AsDateTime,

                           FieldByName('CTR_VALREC').AsFloat -
                           FieldByName('CTR_VALJUR').AsFloat +
                           FieldByName('CTR_VALDES').AsFloat,

                           FieldByName('CTR_VALREC').AsFloat -
                           FieldByName('CTR_VALJUR').AsFloat +
                           FieldByName('CTR_VALDES').AsFloat,

                           FieldByName('CTR_DESCOB').AsFloat,
                           FieldByName('CTR_DESCON').AsString,
                           FieldByName('CTR_HIST01').AsString,
                           FieldByName('CTR_HIST02').AsString,
                           '',
                           '',
                           '',
                           '',
                           '',
                           0.0,
                           0,
                           0,
                           '',
                           '',
                           'ESTORNO',
                           Self.Name + IIF(blnResCai, 'RESCAI',''),
                           0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           False,
                           False,
                           False,
                           False,
                           False,
                           False,
                           0,
                           '',
                           '',
                           FAlse,
                           '',
                           0);

          fltValorTotal := fltValorTotal + (fltValLan * intFatMult);

          If (Not blnConjugadas) Then
          Begin

            If fEmptyStr(strSeqCon) Then
            Begin
              strSeqCon := FieldByName('CTR_SEQCON').AsString;
              strEmpRcx := FieldByName('CTR_EMPBAI').AsString;
            End;

            If Not blnConjugadas Then
              pRealizaLCDocumentosTransferidos;

            pApagaChequeCartao(strSeqCon,
                               strEmpRcx,
                               fltValCar,
                               fltChqVis,
                               fltChqPre);
          End;

        End;

        Next;
      End;
      {*****************************************}
      {* VOLTA PARA A DUPLICATA PRINCIPAL      *}
      {**************************************MV*}
      First;
      EnableControls;
    End;

    strSeqBai := Trim(strSeqBai);
    
    If RightStr(strSeqBai, 1) = ',' Then
      strSeqBai[Length(strSeqBai)] := ' ';

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + cdsDados.FieldByName('CTR_TABELA').AsString + ' ';
    strSQL := strSQL + 'SET ';

    If blnSomenteParcial Then
    Begin
      // strSQL := strSQL + '  CTR_VALDUP = CTR_VALDUP + :VALORI, ';
      strSQL := strSQL + '  CTR_VALDUP = IF(:VALANT = 0, CTR_VALDUP + :VALORI, :VALANT), ';
      strSQL := strSQL + '  CTR_VALORI = CTR_VALDUP, ';

      strSQL := strSQL + '  CTR_DTAVEN = IF(:VALANT = 0, CTR_DTAVEN, :DTAVEN),           ';

      strSQL := strSQL + '  CTR_DESSUJ = :DESANT, ';
      strSQL := strSQL + '  CTR_JURSUJ = :JURANT, ';

    End
    Else
    Begin
      strSQL := strSQL + '  CTR_VALORI = :VALORI, ';
      strSQL := strSQL + '  CTR_VALDUP = :VALORI, ';
    End;

    strSQL := strSQL + '  CTR_CTABAI = NULL, ';
    strSQL := strSQL + '  CTR_PORBAI = NULL, ';
    strSQL := strSQL + '  CTR_DOCBAI = NULL, ';
    strSQL := strSQL + '  CTR_HISBAI = NULL, ';
    strSQL := strSQL + '  CTR_OPEBAI = NULL, ';
    strSQL := strSQL + '  CTR_VALREC = 0,    ';
    strSQL := strSQL + '  CTR_DTAREC = NULL, ';
    strSQL := strSQL + '  CTR_DTABAI = NULL, ';
    strSQL := strSQL + '  CTR_EMPBAI = NULL, ';
    strSQL := strSQL + '  CTR_VALDES = 0,    ';
    strSQL := strSQL + '  CTR_VALJUR = 0,    ';
    strSQL := strSQL + '  CTR_ORIF11 = "N",  ';

    strSQL := strSQL + '  CTR_SEQMOD = NULL, ';
    strSQL := strSQL + '  CTR_DINHEI = NULL, ';
    strSQL := strSQL + '  CTR_CHQAVI = NULL, ';
    strSQL := strSQL + '  CTR_CHQPRE = NULL, ';
    strSQL := strSQL + '  CTR_CARTAO = NULL, ';
    strSQL := strSQL + '  CTR_RECDIN = NULL, ';
    strSQL := strSQL + '  CTR_RECCHE = NULL, ';
    strSQL := strSQL + '  CTR_RECPRE = NULL, ';
    strSQL := strSQL + '  CTR_RECCAR = NULL, ';

    strSQL := strSQL + '  CTR_RESCAI = NULL  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  CTR_SEQBAI = 0 ';

   // If blnResCai Then
     // strSQL := strSQL + '  AND CTR_RESCAI = 1 ';

    {*****************************************}
    {* ESTORNA A DUPLICATA PRINCIPAL         *}
    {**************************************MV*}
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Params.FindParam('VALORI') <> Nil Then
        ParamByName('VALORI').AsFloat := fltValorTotal;

      If Params.FindParam('VALANT') <> Nil Then
        ParamByName('VALANT').AsFloat := fltValAnt;

      If Params.FindParam('DTAVEN') <> Nil Then
        ParamByName('DTAVEN').AsDateTime := dtaVenAnt;

      If Params.FindParam('JURANT') <> Nil Then
        ParamByName('JURANT').AsFloat := fltJurAnt;

      If Params.FindParam('DESANT') <> Nil Then
        ParamByName('DESANT').AsFloat := fltDesAnt;

      ParamByName('NUMDUP').AsString := cdsDados.FieldByName('NUMDUP').AsString;
      ParamByName('PARCEL').AsString := cdsDados.FieldByName('PARDUP').AsString;
      ParamByName('ESPDOC').AsString := cdsDados.FieldByName('CTR_ESPDOC').AsString;
      ParamByName('CODEMP').AsString := cdsDados.FieldByName('CTR_CODEMP').AsString;
      ParamByName('CODCLI').AsString := cdsDados.FieldByName('CTR_CODCLI').AsString;
      ExecSQL;
      Close;
    End;

    If Not fEmptyStr(strSeqBai) Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE * FROM ';
      strSQL := strSQL + cdsDados.FieldByName('CTR_TABELA').AsString + ' ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
      strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
      strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
      strSQL := strSQL + '  CTR_SEQBAI IN ( ' + strSeqBai + ' )';

      If blnResCai Then
        strSQL := strSQL + '  AND CTR_RESCAI = 1 ';

      {*****************************************}
      {* DELETA AS DUPLICATAS PARCIAIS         *}
      {**************************************MV*}
      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDUP').AsString := cdsDados.FieldByName('NUMDUP').AsString;
        ParamByName('PARCEL').AsString := cdsDados.FieldByName('PARDUP').AsString;
        ParamByName('ESPDOC').AsString := cdsDados.FieldByName('CTR_ESPDOC').AsString;
        ParamByName('CODEMP').AsString := cdsDados.FieldByName('CTR_CODEMP').AsString;
        ParamByName('CODCLI').AsString := cdsDados.FieldByName('CTR_CODCLI').AsString;
        Open;

        While Not Eof Do
        Begin
          fApagaDuplicataContasReceber(qryGen, cdsDados.FieldByName('CTR_TABELA').AsString, Self.Name);
          Next;
        End;

        Close;
      End;
    End;

    If Length(arrLogCtr) > 0 Then
    Begin
      If Not fGravaLogCtr(arrLogCtr) Then
        Raise Exception.Create('Ocorreu um erro!');
    End;

    If (Not blnConjugadas) Then
    Begin
      pCriaTemporaria;
      fCommit;

      strMensagem := 'Duplicata estornada com sucesso!';
      If (Not fEmptyStr(strDocCre)) Then
        strMensagem := strMensagem + #13#10 + 'Há um crédito de número (' + strDocCre + '). ' +
                                              'Favor verificar. ';

      If Not fEmptyStr(strDocsNaoEnc) Then
        fMensagem('ATENÇÃO!', 'Não foram encontrados os ' + strDocsNaoEnc + '. Favor verificar.', ['&Ok']);

      fMensagem('', strMensagem, ['&O k']);
      pLimpaCampos;
    End;

    FreeAndNil(qryGen);
  Except
    On E: Exception Do
    Begin
      cdsDados.EnableControls;
      FreeAndNil(qryGen);
      If blnConjugadas Then
        Raise Exception.Create(E.Message)
      Else
      Begin
        fRollBack;
        pMensagensErro('Erro: ' + E.Message,'[pEstornaDuplicataParcial]');
      End;
    End;
  End;
end;

{******************************************}
{* strMarDes:                             *}
{* -> 'M': Marca                          *}
{* -> 'D': Desmarca                       *}
{* -> 'T': Desmarca Todas as relacionadas *}
{***************************************MV*}
procedure TfrmEstornoCtaReceber.pMarcaDuplicata(strMarDes: String);
  Var
    intRec: Integer;
begin

  Try
    intRec := cdsDados.RecNo;
    cdsDados.DisableControls;

    cdsDados.Filter := 'NUMDUP = ' + QuotedStr(cdsDados.FieldByName('NUMDUP').AsString) + ' AND ' +
                       'PARDUP = ' + QuotedStr(cdsDados.FieldByName('PARDUP').AsString) + ' AND ' +
                       'CTR_ESPDOC = ' + QuotedStr(cdsDados.FieldByName('CTR_ESPDOC').AsString) + ' AND ' +
                       'CTR_CODEMP = ' + QuotedStr(cdsDados.FieldByName('CTR_CODEMP').AsString) + ' AND ' +
                       'CTR_CODCLI = ' + QuotedStr(cdsDados.FieldByName('CTR_CODCLI').AsString) +
                       IIF(strMarDes <> 'T', ' AND CTR_SEQBAI = ' + QuotedStr(cdsDados.FieldByName('CTR_SEQBAI').AsString), '');
    cdsDados.Filtered := True;

    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      cdsDados.Edit;
      cdsDados.FieldByName('CTR_MARDES').AsString := strMarDes;
      cdsDados.Post;

      cdsDados.Next;
    End;

  Finally
    cdsDados.Filtered := False;
    cdsDados.Filter   := '';
    cdsDados.EnableControls;
    cdsDados.RecNo := intRec;
    Application.ProcessMessages;
  End;

end;

procedure TfrmEstornoCtaReceber.pRealizaLCDocumentosTransferidos;
  Var
    qryChq: TUniQuery;
    qryCrt: TUniQuery;
    fltTotalChqVis: Double;
    fltTotalChqPre: Double;
    fltTotalCartao: Double;
begin
  If intSeqConEstorno < 0 Then
  Begin
    Exit;
  End;

  If dtaDtaRcx <> dtaDtaBaiEstorno Then
  Begin
    Exit;
  End;

  fltTotalChqVis := 0;
  fltTotalChqPre := 0;
  fltTotalCartao := 0;

  qryChq := fCarregaChequesTransferidos(intSeqConEstorno, strCodEmpEstorno);
  While (Not qryChq.Eof) Do
  Begin
    If qryChq.FieldByName('CHQ_DTACAD').AsDateTime = qryChq.FieldByName('CHQ_DTAVEN').AsDateTime Then
      fltTotalChqVis := fltTotalChqVis + qryChq.FieldByName('CHQ_VALCHQ').AsFloat
    ELse
      fltTotalChqPre := fltTotalChqPre + qryChq.FieldByName('CHQ_VALCHQ').AsFloat;

    qryChq.Next;
  End;

  qryCrt := fCarregaCartoesTransferidos(intSeqConEstorno, strCodEmpEstorno);
  While (Not qryCrt.Eof) Do
  Begin
    fltTotalCartao := fltTotalCartao + qryChq.FieldByName('MCA_VALSTA').AsFloat;
    qryCrt.Next;
  End;

  If Not fLancaLCTransferidos(fltTotalChqVis, fltTotalChqPre, fltTotalCartao,
    'REF. A DOCUMENTOS TRANSFERIDOS.') Then
  Begin
    Raise Exception.Create('Não foi possível gravar o caixa dos documentos transferidos.');
  End;

  intSeqConEstorno := -1;

end;

function TfrmEstornoCtaReceber.fLancaLCTransferidos(fltTotalChqVis,
  fltTotalChqPre, fltTotalCartao: Double; strHistorico: String): Boolean;
  Var
    fltTotalDoc: Double;
    strSeqRcx: String;
begin
  Result := True;
  fltTotalDoc := fltTotalChqVis+fltTotalChqPre+fltTotalCartao;
  If fFormataFloat(fltTotalDoc, 2) <> 0 Then
  Begin
    Result := untCadRcxx.fGravaCadRcx(strSeqRcx,
                                      '',                                      // Cliente
                                      strOpeBaiEstorno,                        // Operador
                                      'EST.TF.',                               // Documento
                                      'LC',                                    // Espécie
                                      VS_strCodEmp,                            // Empresa
                                      dtaDtaRcx,                                // Data de Cadastro
                                      Time,                                    // Hora de Cadastro
                                      '',                                      // Duplicata
                                      '',                                      // Parcela
                                      'REF. A ESTORNO. CTA. RECEBER',          // Descrição
                                      '',                                      // Juros / Desconto
                                      '',                                      // Identificação de Fechamento
                                      '',                                      // Forma de Pagamento
                                      fltTotalDoc, // Valor do Documento
                                      0.0,                                     // Valor do Desconto
                                      0.0,                                     // Valor do Juros
                                      0,                                       // Dinheiro recebido
                                      fltTotalChqVis,                          // Cheque a vista
                                      fltTotalChqPre,                          // Cheque pre datado
                                      fltTotalCartao,                          // Valor em Cartã
                                      0,                                       // Valor em Ordem de Pagamento
                                      0.0,                                     // Valor do Crédito
                                      0.0,                                     // Valor de Financeira
                                      0.0,                                     // Valor de outros
                                      0.0,                                     // Venda a prazo
                                      '',                                      // Num. do Romaneio
                                      StrToInt(fRetRcxCon),                    // Sequencial de Controle
                                      0,     // Sequencial de Baixa (Duplicata)
                                      fCfgSisL('SQFCRX'),                      // Sequencial de Fechamento parcial de caixa
                                      '',      // Empresa da duplicata
                                      '',      // MotDes
                                      IIF(strNomeTabela='CADREC', 1, 2),
                                      0.00,
                                      0.00,
                                      0.00,
                                      0.00,
                                      0.00);      // Identificação do Caixa
  End;
end;

procedure TfrmEstornoCtaReceber.dbgDuplicatasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Return: pSelecionaDuplicata;
    VK_Escape: pLimpaCampos;
    VK_F10   : Begin
                 Key := 0;
                 btnConfirma.Click;
               End;
  End;
  
end;

procedure TfrmEstornoCtaReceber.pSelecionaDuplicata;
  Var
    strMarcar: String;
    intRecNo: Integer;
    strQtdDup: String;
    strSeqCon: String;
    strEmpRcx: String;

    blnDocumentosOk: Boolean;
    strPorBai: String;
begin
  strMarcar := 'D';

  If (Not cdsDados.Active) Then
    Exit;

  If (cdsDados.IsEmpty) Then
    Exit;

  Try

    With cdsDados Do
    Begin

      If FieldByName('CTR_MARDES').AsString <> 'M' Then
      Begin

        intRecNo := cdsDados.RecNo;
        If cdsDados.Locate('CTR_MARDES', 'M', []) Then
        Begin
          fMensagem('ATENÇÃO!', 'É necessário baixar uma duplicata por vez!', ['&Ok']);
          cdsDados.RecNo := intRecNo;
          Exit;
        End;

        cdsDados.RecNo := intRecNo;

        {*****************************************}
        {* CASO FOR A DUPLICATA PRINCIPAL, MARCA *}
        {**************************************MV*}
        If FieldByName('CTR_SEQBAI').AsInteger = 0 Then
          strMarcar := 'M'

        Else
        {*****************************************}
        {* CASO NÃO FOR, VERIFICA SE A DUPLICATA *}
        {* PRINCIPAL ESTA BAIXADA.               *}
        {**************************************MV*}
        Begin

  //        If (fVerificaDuplicataPrincipal)              Or
  //           ((FieldByName('CTR_SEQBAI').AsInteger > 0) And
  //            (intPrimSeqBai > 0))                      Then
          If (fVerificaDuplicataPrincipal) Then
          Begin

            If fTemDuplicataPosteriorBaixada(cdsDados.FieldByName('NUMDUP').AsString,
                                             cdsDados.FieldByName('PARDUP').AsString,
                                             cdsDados.FieldByName('CTR_ESPDOC').AsString,
                                             cdsDados.FieldByName('CTR_CODEMP').AsString,
                                             cdsDados.FieldByName('CTR_CODCLI').AsString,
                                             cdsDados.FieldByName('CTR_SEQBAI').AsInteger) Then
              fMensagem('', 'Há duplicata(s) parciais baixadas posteriormente. '+ #13#10 +
                            'As duplictas parciais devem ser estornadas a partir da última baixa.', ['&O k'])

            Else strMarcar := 'M';

          End Else
            fMensagem('', 'Primeiro você deve estornar a duplicata principal!', ['&O k']);

        End;
      End

      Else If FieldByName('CTR_SEQBAI').AsInteger = 0 Then
        strMarcar := 'T';

    End;

    If strMarcar = 'M' Then
    Begin

      If (cdsDados.FieldByName('CTR_RESCAI').AsInteger = 0) Then
      Begin
        strSeqCon := cdsDados.FieldByName('CTR_SEQCON').AsString;
        strEmpRcx := cdsDados.FieldByName('CTR_EMPBAI').AsString;
      End;

      pVerifQtdDuplicatas(edtNumDup.Text,
                          edtEspDoc.Text,
                          edtParcel.Text,
                          edtCodEmp.Text,
                          edtCodCli.Text,
                          cdsDados.FieldByName('CTR_SEQBAI').AsInteger,
                          strQtdDup,
                          strSeqCon,
                          strEmpRcx,
                          cdsDados.FieldByName('CTR_RESCAI').AsInteger);

      blnDocumentosOk := True;

      If StrToIntDef(strSeqCon, 0) > 0 Then
      Begin
        blnDocumentosOk := fVerificaDocumentosBaixados(strSeqCon, strEmpRcx);
        If blnDocumentosOk Then
          blnDocumentosOk := fVerificaDatasDiferentes(strSeqCon, strEmpRcx);
      End;

      If fHouveTransferenciaCartao(cdsDados.FieldByName('CTR_SEQCON').AsInteger,
                                   cdsDados.FieldByName('CTR_EMPBAI').AsString) Then
      Begin
        blnDocumentosOk := False;
      End;

      If fHouveTransferenciaCheque(cdsDados.FieldByName('CTR_SEQCON').AsInteger,
                                   cdsDados.FieldByName('CTR_EMPBAI').AsString) Then
      Begin
        blnDocumentosOk := False;
      End;

      If (blnDocumentosOk) Then
      Begin
        If StrToIntDef(strQtdDup, 0) > 1 Then
        Begin
          If Not fChamaTelaConjugadas(strSeqCon, strEmpRcx, cdsDados.FieldByName('CTR_RESCAI').AsInteger) Then
          Begin
            strMarcar := 'D';
          End
          Else
          Begin

            If (fMensagem('ATENÇÃO!', 'Confirma o estorno da duplicata selecionada?', ['&Sim', '&Não']) = 1) And
               fPedePortador(strPorBai) Then
            Begin

              pEstornaDuplicataConjugadas(strSeqCon,
                                          strEmpRcx,
                                          cdsDados.FieldByName('CTR_RESCAI').AsInteger,
                                          cdsDados.FieldByName('CTR_DTAREC').AsDateTime,
                                          cdsDados.FieldByName('CTR_OPEBAI').AsString,
                                          strPorBai);
              strMarcar := '';
            End;

          End;

        End;

      End
      Else
        strMarcar := 'D';

    End;

    If Not fEmptyStr(strMarcar) Then
    Begin
      pMarcaDuplicata(strMarcar);
      dbgDuplicatas.Refresh;
    End;

  Except
    On E: ExceptionAutcom Do
    Begin
      fMensagem('ATENÇÃO!', E.Message, ['&Ok']);
    End;

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pSelecionaDuplicata]');
    End;
  End;

end;

{*****************************************}
{* RETORNA TRUE, SE HÁ ALGUMA DUPLICATA  *}
{* PRINCIPAL SELECIONADA                 *}
{**************************************MV*}
function TfrmEstornoCtaReceber.fVerificaDuplicataPrincipal: Boolean;
begin

  Result := fCtrDuplicataPrincipalBaixada(cdsDados.FieldByName('NUMDUP').AsString,
                                          cdsDados.FieldByName('PARDUP').AsString,
                                          cdsDados.FieldByName('CTR_ESPDOC').AsString,
                                          cdsDados.FieldByName('CTR_CODEMP').AsString,
                                          cdsDados.FieldByName('CTR_CODCLI').AsString,
                                          cdsDados.FieldByName('CTR_SEQBAI').AsInteger);

(*  Try
    Result := False;

    intRec := cdsDados.RecNo;
    cdsDados.DisableControls;

    {****************************************}
    {* FILTRA REGISTRO                      *}
    {*************************************AF*}
    cdsDados.Filter := 'NUMDUP = ' + QuotedStr(cdsDados.FieldByName('NUMDUP').AsString) + ' AND ' +
                       'PARDUP = ' + QuotedStr(cdsDados.FieldByName('PARDUP').AsString) + ' AND ' +
                       'CTR_ESPDOC = ' + QuotedStr(cdsDados.FieldByName('CTR_ESPDOC').AsString) + ' AND ' +
                       'CTR_CODEMP = ' + QuotedStr(cdsDados.FieldByName('CTR_CODEMP').AsString) + ' AND ' +
                       'CTR_CODCLI = ' + QuotedStr(cdsDados.FieldByName('CTR_CODCLI').AsString) + ' AND ' +
                       'CTR_SEQBAI = 0 AND ' +
                       'CTR_MARDES = ' + QuotedStr('M');
    cdsDados.Filtered := True;

    If cdsDados.RecordCount = 1 Then
      Result := True;
    
  Finally
    cdsDados.Filtered := False;
    cdsDados.Filter   := '';
    cdsDados.EnableControls;
    cdsDados.RecNo := intRec;
  End;*)

end;

procedure TfrmEstornoCtaReceber.dbgDuplicatasDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  If Not cdsDados.Active Then
    Exit;

  If cdsDados.FieldByName('CTR_MARDES').AsString = 'M' Then
  Begin
    dbgDuplicatas.Canvas.Font.Color := clBlue;
    dbgDuplicatas.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;

end;

procedure TfrmEstornoCtaReceber.btnSairEstClick(Sender: TObject);
begin
  inherited;
  Close;
end;

Function TfrmEstornoCtaReceber.fHouveTransferenciaCartao(intSeqCon: Integer; strEmpRcx: String): Boolean;
  Var
    qryGen: TUniQuery;
    strSql: String;
Begin
  If Not blnResCai Then
  Begin
    Result := False;
    Exit;
  End;

  qryGen := fCarregaCartoesTransferidos(intSeqCon, strEmpRcx);

  Result := Not qryGen.IsEmpty;

  If Result Then
    fMensagem('','Há cartões transferidos relativos a essa baixa!.' + #13 +
                 'O estorno deve ser feito em Controle Financeiro\Contas a Receber\Estorno de Contas a Receber.', ['&OK']);

  qryGen.Close;

  FreeAndNil(qryGen);
End;

Function TfrmEstornoCtaReceber.fHouveTransferenciaCheque(intSeqCon: Integer; strEmpRcx: String): Boolean;
  Var
    qryGen: TUniQuery;
    strSql: String;
Begin
  If Not blnResCai Then
  Begin
    Result := False;
    Exit;
  End;

  qryGen := fCarregaChequesTransferidos(intSeqCon, strEmpRcx);

  Result := Not qryGen.IsEmpty;

  If Result Then
    fMensagem('','Há cheques transferidos relativos a essa baixa!' + #13 +
                 'O estorno deve ser feito em Controle Financeiro\Contas a Receber\Estorno de Contas a Receber.', ['&OK']);

  qryGen.Close;

  FreeAndNil(qryGen);
End;

procedure TfrmEstornoCtaReceber.btnConfirmaClick(Sender: TObject);
  Var
    strPorBai: String;
begin
  inherited;

  If (cdsDados.Active = False) And (cdsDados.IsEmpty) Then
  Begin
    Exit;
  End;

  Try
    btnConfirma.Enabled := False;

    If fRetDuplicatasSelecionadas <= 0 Then
      Exit;

    {*****************************************}
    {* ESTORNO PELO RCX SOMENTE EH PERMITIDO *}
    {* QUANDO FEITO NO MESMO DIA             *}
    {**************************************JB*}
    If (blnResCai) And
       (cdsDados.FieldByName('CTR_DTAREC').AsDateTime <> VS_Date) Then
    Begin
      fMensagem('', 'Estorno não permitido, o resumo de caixa somente estorna a duplicata quando a data de recebimento for a mesma do dia.' + #13#10 +
                    'Por favor, estornar pelo financeiro.', ['&Ok']);
      Exit;
    End;

    If (Not fVerSeqBai(edtNumDup.Text, edtEspDoc.Text, edtParcel.Text, edtCodEmp.Text, edtCodCli.Text)) Then
    Begin
      fMensagem('', 'Estorno não permitido, pois a duplicata principal não foi encontrada no Contas a Receber.' + #13#10 +
                    'Possível motivo: a duplicata já foi agrupada.', ['&Ok']);
      Exit;
    End;                                                 

    If cdsDados.FieldByName('CTR_EMPBAI').AsString <> VS_strCodEmp Then
    Begin
      fMensagem('','Permitido apenas estornar documentos baixados pela empresa ' + VS_strCodEmp + '!', ['&OK']);
      Exit;
    End;

    If fHouveTransferenciaCartao(cdsDados.FieldByName('CTR_SEQCON').AsInteger,
                                 cdsDados.FieldByName('CTR_EMPBAI').AsString) Then
    Begin
      Exit;
    End;

    If fHouveTransferenciaCheque(cdsDados.FieldByName('CTR_SEQCON').AsInteger,
                                 cdsDados.FieldByName('CTR_EMPBAI').AsString) Then
    Begin
      Exit;
    End;

    If (pnlDados.Visible) And ((fVerificaDuplicataPrincipal) Or (cdsDados.FieldByName('CTR_SEQBAI').AsInteger > 0)) Then
    Begin
      If (fMensagem('', 'Confirma estorno da(s) duplicata(s) selecionada(s)?', ['', '']) = 1) And
         fPedePortador(strPorBai) Then
        pEstornaDuplicataParcial(False, strPorBai);

      pSetFocus(edtNumDup);
    End;

  Finally
    btnConfirma.Enabled := True;
  End;

end;

function TfrmEstornoCtaReceber.fRetDuplicatasSelecionadas: Integer;
  Var
    intRec: Integer;
begin

  Try
    intRec := cdsDados.RecNo;
    cdsDados.DisableControls;

    {****************************************}
    {* FILTRA REGISTRO                      *}
    {*************************************AF*}
    cdsDados.Filter   := 'CTR_MARDES = ' + QuotedStr('M');
    cdsDados.Filtered := True;

    Result := cdsDados.RecordCount;

  Finally
    cdsDados.Filtered := False;
    cdsDados.Filter   := '';
    cdsDados.EnableControls;
    cdsDados.RecNo := intRec;
  End;

end;

procedure TfrmEstornoCtaReceber.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmEstornoCtaReceber.fVerSeqBai(strNumDup, strEspDoc, strParcel, strCodEmp, strCodCli: String): Boolean;
  Var
    strSQL: String;
    qryAux: TUniQuery;
begin

  Try
    qryAux := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   COUNT(*) AS QTD ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + strNomeTabela;
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '   CTR_SEQBAI = 0           ';

    If blnResCai Then
    Begin
      strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(strSQL, strNomeTabela, IIF(strNomeTabela = 'CADREC', 'CADRECX', 'CADREC'));

      {***********************************}
      { SOMA OS RESULTADOS DAS SELECTS    }
      {********************************JB*}
      strSQL := 'SELECT SUM(QTD) AS QTD FROM ( ' + strSQL + ' ) TABTMP';

    End;

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(strSQL);
    qryAux.ParamByName('NUMDUP').AsString := strNumDup;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('PARCEL').AsString := strParcel;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.Open;

    Result := (qryAux.FieldByName('QTD').AsInteger > 0);

    qryAux.Close;

  Finally
    FreeAndNil(qryAux);
  End;

end;

function TfrmEstornoCtaReceber.fVerConfirmada(strNumDup, strEspDoc, strParcel, strCodEmp, strCodCli: String): Boolean;
  Var
    strSQL: String;
    qryAux: TUniQuery;
begin

  Try
    qryAux := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   CTR_NUMDUP ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CTRCNF ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '   CTR_SEQBAI = 0           ';

    strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(strSQL, 'CTRCNF', 'CTRCNFX');

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(strSQL);
    qryAux.ParamByName('NUMDUP').AsString := strNumDup;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('PARCEL').AsString := strParcel;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.Open;

    Result := Not qryAux.IsEmpty;

    qryAux.Close;

  Finally
    FreeAndNil(qryAux);
  End;

end;

procedure TfrmEstornoCtaReceber.edtCodEmpKeyPress(Sender: TObject;
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

procedure TfrmEstornoCtaReceber.pDeterminaModalidadeEstorno(strNumDup,
  strParcel, strEspDoc, strCodCli, strCodEmp: String; intSeqBai: Integer;
  fltValDup: Double; var fltValDin, fltValCar, fltChqVis, fltChqPre,
  fltOrdRec, fltValFin: Double; Var strDocCre, strSeqCon, strEmpRcx: String);
  Var
    qryAux: TUniQuery;
    qryDupUni: TUniQuery;
    intQtdMod: Integer;

    function fDuplicataUnica: Boolean;
    begin

      qryDupUni.SQL.Clear;
      qryDupUni.SQL.Add('SELECT ');
      qryDupUni.SQL.Add('  COUNT(*) AS QTD ');
      qryDupUni.SQL.Add('FROM ');
      qryDupUni.SQL.Add('  CADRCXX ');
      qryDupUni.SQL.Add('WHERE ');
      qryDupUni.SQL.Add('  RCX_SEQCON = :SEQCON AND ');
      qryDupUni.SQL.Add('  RCX_CODEMP = :CODEMP AND ');
      qryDupUni.SQL.Add('  (RCX_JURDES = "" OR RCX_JURDES IS NULL) ');

      qryDupUni.ParamByName('CODEMP').AsString  := strEmpRcx;
      qryDupUni.ParamByName('SEQCON').AsInteger := StrToIntDef(strSeqCon, 0);
      qryDupUni.Open;
      Result := (qryDupUni.FieldByName('QTD').AsInteger = 1);
      qryDupUni.Close;

    end;

    procedure pDeterminaModalidades;
      Var
        blnDupUnica: Boolean;
    begin
      intQtdMod := 0;
      fltValDin := 0.0;
      fltValCar := 0.0;
      fltChqVis := 0.0;
      fltChqPre := 0.0;
      fltOrdRec := 0.0;
      fltValFin := 0.0;

      If qryAux.IsEmpty Then
      Begin
        Exit;
      End;

      strSeqCon := qryAux.FieldByName('RCX_SEQCON').AsString;
      strEmpRcx := qryAux.FieldByName('RCX_CODEMP').AsString;

      blnDupUnica := fDuplicataUnica;

      If blnDupUnica Then
        intQtdMod := 1;

      If qryAux.FieldByName('RCX_DINREC').AsFloat <> 0.0 Then
      Begin
        If (blnDupUnica) Then
        Begin
          fltValDin := qryAux.FieldByName('RCX_DINREC').AsFloat;
        End
        Else
        Begin
          fltValDin := fltValDup;
          Inc(intQtdMod);
        End;

      End;

      If qryAux.FieldByName('RCX_CARREC').AsFloat <> 0.0 Then
      Begin
        If (blnDupUnica) Then
        Begin
          fltValCar := qryAux.FieldByName('RCX_CARREC').AsFloat;
        End
        Else
        Begin
          fltValCar := fltValDup;
          Inc(intQtdMod);
        End;
      End;

      If qryAux.FieldByName('RCX_CHQAVI').AsFloat <> 0.0 Then
      Begin
        If (blnDupUnica) Then
        Begin
          fltChqVis := qryAux.FieldByName('RCX_CHQAVI').AsFloat;
        End
        Else
        Begin
          fltChqVis := fltValDup;
          Inc(intQtdMod);
        End;
      End;

      If qryAux.FieldByName('RCX_CHQPRE').AsFloat <> 0.0 Then
      Begin
        If (blnDupUnica) Then
        Begin
          fltChqPre := qryAux.FieldByName('RCX_CHQPRE').AsFloat;
        End
        Else
        Begin
          fltChqPre := fltValDup;
          Inc(intQtdMod);
        End;
      End;

      If qryAux.FieldByName('RCX_ORDREC').AsFloat <> 0.0 Then
      Begin
        If (blnDupUnica) Then
        Begin
          fltOrdRec := qryAux.FieldByName('RCX_ORDREC').AsFloat;
        End
        Else
        Begin
          fltOrdRec := fltValDup;
          Inc(intQtdMod);
        End;
      End;

      If qryAux.FieldByName('RCX_VALFIN').AsFloat <> 0.0 Then
      Begin
        If (blnDupUnica) Then
        Begin
          fltValFin := qryAux.FieldByName('RCX_VALFIN').AsFloat;
        End
        Else
        Begin
          fltValFin := fltValDup;
          Inc(intQtdMod);
        End;
      End;

    end;

    procedure pProcuraCredito;
      Var
        qryDocCre: TUniQuery;
    begin

      strDocCre := '';

      qryDocCre := fCriaQuery(Self);
      qryDocCre.SQL.Add('SELECT ');
      qryDocCre.SQL.Add('  RCX_NUMDOC ');
      qryDocCre.SQL.Add('FROM ');
      qryDocCre.SQL.Add('  CADRCXX ');
      qryDocCre.SQL.Add('WHERE ');
      qryDocCre.SQL.Add('  RCX_CODEMP = :CODEMP AND ');
      qryDocCre.SQL.Add('  RCX_SEQCON = :SEQCON AND ');
      qryDocCre.SQL.Add('  RCX_ESPDOC = "CC" ');

      qryDocCre.ParamByName('CODEMP').AsString  := strEmpRcx;
      qryDocCre.ParamByName('SEQCON').AsInteger := StrToIntDef(strSeqCon, 0);
      qryDocCre.Open;

      If (Not qryDocCre.IsEmpty) Then
        strDocCre := qryDocCre.FieldByName('RCX_NUMDOC').AsString;

      qryDocCre.Close;

    end;
begin

  strSeqCon := '';
  strEmpRcx := '';

  qryAux := fCriaQuery(Self);
  qryDupUni := fCriaQuery(Self);

  {***************************************}
  {* ACHA A DUPLICATA NO CAIXA           *}
  {************************************MV*}
  qryAux.SQL.Clear;
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  RCX_DINREC, ');
  qryAux.SQL.Add('  RCX_CARREC, ');
  qryAux.SQL.Add('  RCX_CHQAVI, ');
  qryAux.SQL.Add('  RCX_CHQPRE, ');
  qryAux.SQL.Add('  RCX_ORDREC, ');
  qryAux.SQL.Add('  RCX_VALFIN, ');
  qryAux.SQL.Add('  RCX_SEQCON, ');
  qryAux.SQL.Add('  RCX_CODEMP ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  CADRCXX ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  RCX_NUMDUP = :NUMDUP AND ');
  qryAux.SQL.Add('  RCX_PARCEL = :PARCEL AND ');
  qryAux.SQL.Add('  RCX_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  RCX_CODCLI = :CODCLI AND ');
  qryAux.SQL.Add('  RCX_EMPDUP = :CODEMP AND ');
  qryAux.SQL.Add('  RCX_SEQBAI = :SEQBAI AND ');
  qryAux.SQL.Add('  (RCX_JURDES = "" OR RCX_JURDES IS NULL) ');

  {*****************************************}
  {* CASO ESTEJA ESTORNANDO UM CC QUE FOI  *}
  {* UTILIZADO NA BAIXA DE UMA DUPLICATA NO*}
  {* CAIXA, PEGA O REGISTRO CORRESPONDENTE *}
  {* À BAIXA, E NÃO O REGISTRO DE INCLUSÃO.*}
  {**************************************MV*}
  If (strEspDoc = 'CC') Then
  Begin
    qryAux.SQL.Add(' AND RCX_VALDOC < 0 ');
  End;

  qryAux.SQL.Add('ORDER BY ');
  qryAux.SQL.Add('  RCX_DTACAD DESC, RCX_HORCAD DESC ');
  qryAux.SQL.Add('LIMIT 1');

  qryAux.ParamByName('NUMDUP').AsString  := strNumDup;
  qryAux.ParamByName('PARCEL').AsString  := strParcel;
  qryAux.ParamByName('ESPDOC').AsString  := strEspDoc;
  qryAux.ParamByName('CODCLI').AsString  := strCodCli;
  qryAux.ParamByName('CODEMP').AsString  := strCodEmp;
  qryAux.ParamByName('SEQBAI').AsInteger := intSeqBai;

  qryAux.Open;
  pDeterminaModalidades;
  qryAux.Close;

  {***************************************}
  {* CASO TENHA MAIS DE UMA MODALIDADE,  *}
  {* JOGA NO DINHEIRO. CASO TENHA UMA MO-*}
  {* DALIDADE, USA A MODALIDADE. CASO NÃO*}
  {* TENHA NENHUMA, PROCURA A PRINCIPAL. *}
  {************************************MV*}
  If (intQtdMod > 1) Then
  Begin
    fltValDin := fltValDup;
    fltValCar := 0.0;
    fltChqVis := 0.0;
    fltChqPre := 0.0;
    fltOrdRec := 0.0;
    fltValFin := 0.0;
  End
  Else If (intQtdMod <= 0) Then
  Begin

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  RCX_DINREC, ');
    qryAux.SQL.Add('  RCX_CARREC, ');
    qryAux.SQL.Add('  RCX_CHQAVI, ');
    qryAux.SQL.Add('  RCX_CHQPRE, ');
    qryAux.SQL.Add('  RCX_ORDREC, ');
    qryAux.SQL.Add('  RCX_VALFIN, ');
    qryAux.SQL.Add('  RCX_SEQCON, ');
    qryAux.SQL.Add('  RCX_CODEMP ');
    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add('  CADRCXX ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  RCX_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('  RCX_SEQCON = :SEQCON ');
    qryAux.SQL.Add('LIMIT 1 ');

    qryAux.ParamByName('CODEMP').AsString  := strEmpRcx;
    qryAux.ParamByName('SEQCON').AsInteger := StrToIntDef(strSeqCon, 0);
    qryAux.Open;
    pDeterminaModalidades;
    qryAux.Close;

    If (intQtdMod <> 1) Then
    Begin
      fltValDin := fltValDup;
      fltValCar := 0.0;
      fltChqVis := 0.0;
      fltChqPre := 0.0;
      fltOrdRec := 0.0;
      fltValFin := 0.0;
    End;

  End;

  pProcuraCredito;

  FreeAndNil(qryAux);
  FreeAndNil(qryDupUni);

  {***************************************}
  {* SEGURANÇA!                          *}
  {************************************MV*}
  If fFormataFloat((fltValDin + fltValCar + fltChqVis + fltChqPre + fltOrdRec + fltValFin), 2) = 0.0 Then
    fltValDin := fltValDup;

end;

procedure TfrmEstornoCtaReceber.pVerifQtdDuplicatas(strNumDup, strEspDoc, strParcel,
  strCodEmp, strCodCli: String; intSeqBai: Integer; Var strQtdDup, strSeqCon, strEmpRcx: String;
  intResCai: Integer);
  Var
    strSQL   : String;
    qryAux   : TUniQuery;
begin

  Try
    qryAux := fCriaQuery(Self);

    {******************************************}
    {* CASO A DUPLICATA NÃO TENHA SEQCON, OU  *}
    {* SEJA, É ANTIGA, BUSCA PRIMEIRO NO CAIXA*}
    {***************************************MV*}
    If StrToIntDef(strSeqCon, 0) = 0 Then
    Begin

      If intResCai = 1 Then
      Begin
        strSQL := '';
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   RCX_SEQCON, ';
        strSQL := strSQL + '   RCX_CODEMP ';
        strSQL := strSQL + ' FROM ';
        strSQL := strSQL + '   CADRCXX ';
        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '   RCX_NUMDUP = :NUMDUP AND ';
        strSQL := strSQL + '   RCX_ESPDOC = :ESPDOC AND ';
        strSQL := strSQL + '   RCX_PARCEL = :PARCEL AND ';
        strSQL := strSQL + '   RCX_EMPDUP = :CODEMP AND ';
        strSQL := strSQL + '   RCX_CODCLI = :CODCLI AND ';
        strSQL := strSQL + '   RCX_SEQBAI = :SEQBAI     ';
        strSQL := strSQL + ' ORDER BY ';
        strSQL := strSQL + '   RCX_SEQCON DESC ';

        With qryAux Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('NUMDUP').AsString  := strNumDup;
          ParamByName('ESPDOC').AsString  := strEspDoc;
          ParamByName('PARCEL').AsString  := strParcel;
          ParamByName('CODEMP').AsString  := strCodEmp;
          ParamByName('CODCLI').AsString  := strCodCli;
          ParamByName('SEQBAI').AsInteger := intSeqBai;
          Open;

          strSeqCon := fieldbyname('RCX_SEQCON').AsString;
          strEmpRcx := FieldByName('RCX_CODEMP').AsString;
        End;

        If strToIntDef(strSeqCon, 0) = 0 Then
          strSeqCon := '-1';

        strSQL := '';
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   COUNT(*) AS QTD ';
        strSQL := strSQL + ' FROM ';
        strSQL := strSQL + '   CADRCXX ';
        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '   RCX_SEQCON = :SEQCON AND ';
        strSQL := strSQL + '   RCX_CODEMP = :CODEMP AND ';
        strSQL := strSQL + '   (RCX_JURDES = "" OR RCX_JURDES IS NULL) ';

        With qryAux Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('SEQCON').AsString := strSeqCon;
          ParamByName('CODEMP').AsString := strEmpRcx;
          Open;
        End;

        strQtdDup := qryAux.FieldByName('QTD').AsString;
      End
      Else
      Begin
        strEmpRcx := '';
        strQtdDup := '0';
        strSeqCon := '-1';
      End;

    End
    Else
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  COUNT(*) AS QTD ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADREC ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CTR_SEQCON = :SEQCON AND ';
      strSQL := strSQL + '  CTR_EMPBAI = :EMPBAI ';

      strSQL := strSQL + '  UNION ALL ' + AnsiReplaceStr(strSQL, 'CADREC', 'CADRECX');

      strSQL := 'SELECT SUM(QTD) AS QTD FROM (' + strSQL + ') AS TMP ';

      With qryAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('SEQCON').AsString := strSeqCon;
        ParamByName('EMPBAI').AsString := strEmpRcx;
        Open;
      End;

      strQtdDup := qryAux.FieldByName('QTD').AsString;

    End;

    qryAux.Close;
  Finally
    FreeAndNil(qryAux);
  End;

end;

procedure TfrmEstornoCtaReceber.pApagaDuplicata(strNumDup, strParcel, strCodEmp, strEspDoc, strCodCli, strNomTab: String;
      intSeqBai: Integer);
  Var
    strSQL       : String;
    qryGen       : TUniQuery;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT * FROM ';
  strSQL := strSQL + strNomTab;
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
  strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  CTR_SEQBAI = :SEQBAI     ';

  If blnResCai Then
     strSQL := strSQL + '  AND CTR_RESCAI = 1 ';

  qryGen := fCriaQuery;

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDUP').AsString  := strNumDup;
    ParamByName('PARCEL').AsString  := strParcel;
    ParamByName('ESPDOC').AsString  := strEspDoc;
    ParamByName('CODEMP').AsString  := strCodEmp;
    ParamByName('CODCLI').AsString  := strCodCli;
    ParamByName('SEQBAI').AsInteger := intSeqBai;
    Open;

    While Not Eof Do
    Begin
      fApagaDuplicataContasReceber(qryGen, strNomTab, Self.Name);
      Next;
    End;

    Close;
  End;

  FreeAndNil(qryGen);
End;

procedure TfrmEstornoCtaReceber.pEstornaDuplicataConjugadas(strCodSeq, strEmpRcx: String;
  intResCai: Integer; dtaDtaRec: TDateTime; strOpeBai: String; strPorBai: String = '');
  Var
    strSQL       : String;
    qryGen       : TUniQuery;
    qryDuplicatas: TUniQuery;

    fltValDin    : Double;
    fltValCar    : Double;
    fltChqVis    : Double;
    fltChqPre    : Double;
    fltOrdRec    : Double;
    fltValFin    : Double;
    arrLogCtr    : TRegistroLogCtr;
    strNomTab    : String;

    fltValLan    : Double;
    strCreDeb    : String;
    strSeqRcx    : String;
    blnResult    : Boolean;
begin

  strDocsNaoEnc := '';

  If fEmptyStr(strOpeBai) Then
    strOpeBai := strLoginUsuarioLogado;

  Try

    qryGen        := fCriaQuery;
    qryDuplicatas := fCriaQuery;

    SetLength(arrLogCtr,0);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CTR_DINHEI AS DINREC, ';
    strSQL := strSQL + '  CTR_CARTAO AS CARREC, ';
    strSQL := strSQL + '  CTR_CHQAVI AS CHQAVI, ';
    strSQL := strSQL + '  CTR_CHQPRE AS CHQPRE, ';
    strSQL := strSQL + '  CTR_ORDPAG AS ORDREC, ';
    strSQL := strSQL + '  CTR_VALFIN AS VALFIN, ';
    strSQL := strSQL + '  CTR_VALREC AS VALREC, ';
    strSQL := strSQL + '  CTR_NUMDUP AS NUMDUP, ';
    strSQL := strSQL + '  CTR_PARCEL AS PARCEL, ';
    strSQL := strSQL + '  CTR_CODEMP AS EMPDUP, ';
    strSQL := strSQL + '  CTR_ESPDOC AS ESPDOC, ';
    strSQL := strSQL + '  CTR_CODCLI AS CODCLI, ';
    strSQL := strSQL + '  CTR_SEQBAI AS SEQBAI, ';
    strSQL := strSQL + '  IFNULL(CTR_VALREC, CTR_VALDUP) AS VALDOC, ';
    strSQL := strSQL + '  AUTOINCREM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_SEQCON = :SEQCON AND ';
    strSQL := strSQL + '  CTR_EMPBAI = :CODEMP ';

    strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(strSQL, 'CADREC', 'CADRECX');

    strSQL := strSQL + 'ORDER BY ';
    strSQL := strSQL + '  AUTOINCREM ';

    With qryDuplicatas Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQCON').AsString := strCodSeq;
      ParamByName('CODEMP').AsString := strEmpRcx;
      Open;
    End;

    If intResCai = 0 Then
      stlConjugadas := TStringList.Create;

    {***********************************}
    {* CASO ALGUMA DUPLICATA CONJUGADA *}
    {* ESTEJA COM O PORBAI VAZIA       *}
    {* POIS ATÉ AGORA FOI VERIFICADO   *}
    {* APENAS INDIVIDUAL               *}
    {********************************AF*}
    If fEmptyStr(strPorBai) Then
    Begin
      While Not qryDuplicatas.Eof Do
      Begin
        pCriaTemporariaConjug(qryDuplicatas.fieldbyname('NUMDUP').AsString,
                              qryDuplicatas.fieldbyname('PARCEL').AsString,
                              qryDuplicatas.fieldbyname('EMPDUP').AsString,
                              qryDuplicatas.fieldbyname('ESPDOC').AsString,
                              qryDuplicatas.fieldbyname('CODCLI').AsString,
                              qryDuplicatas.fieldbyname('SEQBAI').AsInteger);

        fPedePortador(strPorBai);

        If Not fEmptyStr(strPorBai) Then
          Break;

        qryDuplicatas.Next;
      End;
    End;

    qryDuplicatas.First;
    While Not qryDuplicatas.Eof Do
    Begin
      pCriaTemporariaConjug(qryDuplicatas.fieldbyname('NUMDUP').AsString,
                            qryDuplicatas.fieldbyname('PARCEL').AsString,
                            qryDuplicatas.fieldbyname('EMPDUP').AsString,
                            qryDuplicatas.fieldbyname('ESPDOC').AsString,
                            qryDuplicatas.fieldbyname('CODCLI').AsString,
                            qryDuplicatas.fieldbyname('SEQBAI').AsInteger);

      If (fVerConfirmada(qryDuplicatas.fieldbyname('NUMDUP').AsString,
                         qryDuplicatas.fieldbyname('ESPDOC').AsString,
                         qryDuplicatas.fieldbyname('PARCEL').AsString,
                         qryDuplicatas.fieldbyname('EMPDUP').AsString,
                         qryDuplicatas.fieldbyname('CODCLI').AsString)) Then
      Begin
        pMensagemOk('Estorno não permitido, pois a duplicata principal de: ' + qryDuplicatas.fieldbyname('NUMDUP').AsString +
                    ' não foi encontrada ou foi confirmada.');
        Break;
      End;

      qryDuplicatas.Next;
    End;

    fStartTransaction;
    strNomTab := strNomeTabela;

    fltValDin := 0.0;
    fltValCar := 0.0;
    fltChqVis := 0.0;
    fltChqPre := 0.0;
    fltOrdRec := 0.0;
    fltValFin := 0.0;
    fltValLan := 0.0;

    qryDuplicatas.First;
    While Not qryDuplicatas.Eof Do
    Begin

      {*****************************************}
      {* VERIFICA SE É UM CRÉDITO INCLUÍDO DU- *}
      {* RANTE A BAIXA PELO RESUMO DE CAIXA.   *}
      {* CASO POSITIVO, APAGA O CADREC E LANÇA *}
      {* O "LD" NO CAIXA.                      *}
      {**************************************MV*}
      If (qryDuplicatas.fieldbyname('ESPDOC').AsString = 'CC') And
         (qryDuplicatas.fieldbyname('VALDOC').AsFloat > 0.0)   Then
      Begin
        pEstornarLancamentoCreditoCaixa(qryDuplicatas.fieldbyname('NUMDUP').AsString,
                                        qryDuplicatas.fieldbyname('PARCEL').AsString,
                                        qryDuplicatas.fieldbyname('EMPDUP').AsString,
                                        qryDuplicatas.fieldbyname('ESPDOC').AsString,
                                        qryDuplicatas.fieldbyname('CODCLI').AsString,
                                        qryDuplicatas.fieldbyname('SEQBAI').AsInteger,
                                        qryDuplicatas,
                                        strPorBai);
      End
      Else
      Begin
        fltValDin := fltValDin + qryDuplicatas.fieldbyname('DINREC').asfloat;
        fltValCar := fltValCar + qryDuplicatas.fieldbyname('CARREC').asfloat;
        fltChqVis := fltChqVis + qryDuplicatas.fieldbyname('CHQAVI').asfloat;
        fltChqPre := fltChqPre + qryDuplicatas.fieldbyname('CHQPRE').asfloat;
        fltOrdRec := fltOrdRec + qryDuplicatas.fieldbyname('ORDREC').asfloat;
        fltValFin := fltValFin + qryDuplicatas.fieldbyname('VALFIN').asfloat;

        {********************************************}
        {* CASO FOR RESCAI = 0:                     *}
        {*   CASO NÃO VENHA DO RESUMO DE CAIXA, O   *}
        {*   VALOR É A SOMA DOS VALORES RECEBIDOS . *}
        {* CASO FOR RESCAI = 1:                     *}
        {*   CASO VENHA DO RESUMO DE CAIXA, O VALOR *}
        {*   DO LANCAMENTO É A SOMA DAS MODALIDADES.*}
        {**************************************MV,JB*}
        If intResCai = 0 Then
          fltValLan := fltValLan + qryDuplicatas.FieldByName('VALREC').AsFloat
        Else If intResCai = 1 Then
          fltValLan := fltValDin + fltValCar + fltChqVis + fltChqPre + fltOrdRec + fltValFin;

        pCriaTemporariaConjug(qryDuplicatas.fieldbyname('NUMDUP').AsString,
                              qryDuplicatas.fieldbyname('PARCEL').AsString,
                              qryDuplicatas.fieldbyname('EMPDUP').AsString,
                              qryDuplicatas.fieldbyname('ESPDOC').AsString,
                              qryDuplicatas.fieldbyname('CODCLI').AsString,
                              qryDuplicatas.fieldbyname('SEQBAI').AsInteger);

        If (cdsDados.FieldByName('CTR_SEQBAI').AsInteger = 0) Then
        Begin

          With qryDuplicatas Do
          If (FieldByName('ESPDOC').AsString = 'CC') And
              cdsDados.IsEmpty Then // CDSDADOS FAZ O TESTE CTR_DTAREC IS NOT NULL = CC ABERTO DEVE SER APAGADO
          Begin
            pApagaDuplicata(fieldbyname('NUMDUP').AsString,
                            fieldbyname('PARCEL').AsString,
                            fieldbyname('EMPDUP').AsString,
                            fieldbyname('ESPDOC').AsString,
                            fieldbyname('CODCLI').AsString,
                            'CADREC',
                            fieldbyname('SEQBAI').AsInteger);

            pApagaDuplicata(fieldbyname('NUMDUP').AsString,
                            fieldbyname('PARCEL').AsString,
                            fieldbyname('EMPDUP').AsString,
                            fieldbyname('ESPDOC').AsString,
                            fieldbyname('CODCLI').AsString,
                            'CADRECX',
                            fieldbyname('SEQBAI').AsInteger);
          End
          Else pEstornaDuplicataSimples(True, strPorBai);

        End Else
          pEstornaDuplicataParcial(True, strPorBai);

      End;

      If intResCai = 0 Then
      Begin
        stlConjugadas.Add(qryDuplicatas.FieldByName('AUTOINCREM').AsString);
      End;

      qryDuplicatas.Next;

    End;

    If fltValLan > 0 Then
      strCreDeb := 'D'
    Else
    Begin
      strCreDeb := 'C';
      fltValLan := -fltValLan;
      fltValDin := -fltValDin;
      fltValCar := -fltValCar;
      fltChqVis := -fltChqVis;
      fltChqPre := -fltChqPre;
      fltOrdRec := -fltOrdRec;
      fltValFin := -fltValFin;
    End;

    blnResult := True;

    {****************************************************************************}
    {* QUANDO O CLIENTE PAGAVA UMA DUPLICATA UTILIZANDO UM CREDITO O VALOR DO   *}
    {* LANCAMENTO É IGUAL À ZERO, PORTANTO NAO DEVE LANCAR UM LC COM VALOR ZERO *}
    {* EXEMPLO: NF 10 NO VALOR DE 50,00 REAIS, NO CAIXA É FEITO O RECEBIMENTO   *}
    {*          DA MESMA UTILIZANDO UM CREDITO DE EXATAMENTE 50,00 REAIS        *}
    {*************************************************************************JC*}
    If fltValLan <> 0.0 Then
    Begin
      If (intResCai = 1) And (dtaDtaRec = dtaDtaRcx) Then
      Begin
        blnResult := fGravaCadRcx(strSeqRcx,
                                  '',                                      // Cliente
                                  strOpeBai,                               // Operador
                                  'EST.CJ',                                // Documento
                                  IIF(strCreDeb = 'D', 'LD', 'LC'),        // Espécie
                                  VS_strCodEmp,                            // Empresa
                                  dtaDtaRcx,                                 // Data de Cadastro
                                  Time,                                    // Hora de Cadastro
                                  '',                                      // Duplicata
                                  '',                                      // Parcela
                                  'REF. A ESTORNO. CTA. RECEBER',          // Descrição
                                  '',                                      // Juros / Desconto
                                  '',                                      // Identificação de Fechamento
                                  '',                                      // Forma de Pagamento
                                  IIF(strCreDeb = 'D', -1, 1) * fltValLan, // Valor do Documento
                                  0.0,                                     // Valor do Desconto
                                  0.0,                                     // Valor do Juros
                                  IIF(strCreDeb = 'D', -1, IIF(fltValDin < 0, -1, 1)) * fltValDin, // Dinheiro recebido
                                  IIF(strCreDeb = 'D', -1, IIF(fltChqVis < 0, -1, 1)) * fltChqVis, // Cheque a vista
                                  IIF(strCreDeb = 'D', -1, IIF(fltChqPre < 0, -1, 1)) * fltChqPre, // Cheque pre datado
                                  IIF(strCreDeb = 'D', -1, IIF(fltValCar < 0, -1, 1)) * fltValCar, // Valor em Cartã
                                  IIF(strCreDeb = 'D', -1, IIF(fltOrdRec < 0, -1, 1)) * fltOrdRec, // Valor em Ordem de Pagamento
                                  0.0,                                     // Valor do Crédito
                                  IIF(strCreDeb = 'D', -1, IIF(fltValFin < 0, -1, 1)) * fltValFin, // Valor em Financiamento
                                  0.0,                                     // Valor de outros
                                  0.0,                                     // Venda a prazo
                                  '',                                      // Num. do Romaneio
                                  StrToInt(fRetRcxCon),                    // Sequencial de Controle
                                  0,     // Sequencial de Baixa (Duplicata)
                                  fCfgSisL('SQFCRX'),                      // Sequencial de Fechamento parcial de caixa
                                  '',      // Empresa da duplicata
                                  '',      // MotDes
                                  IIF(strNomeTabela='CADREC', 1, 2), // Identificação do Caixa
                                  fltTotGua,
                                  fltTotDol,
                                  fltTotEur,
                                  fltTotPes,
                                  fltTotRea);
      End
      Else
      If intResCai = 0 Then
      Begin
        If fMensagem('', 'Deseja baixar as duplicatas novamente?', ['&Sim', '&Não'], 2) = 1 Then
        Begin
          pCriarFormularios(TfrmBaixaReceber, frmBaixaReceber);
          frmBaixaReceber.stlConjugadas := stlConjugadas;
          frmBaixaReceber.ShowModal;
          pFreeAndNil(frmBaixaReceber);
        End;

        FreeAndNil(stlConjugadas);
        blnResult := True;                                  

        pRealizaLCDocumentosTransferidos;
      End;
    End;

    If blnResult Then
    Begin

      pRealizaLCDocumentosTransferidos;
      pApagaChequeCartao(strCodSeq, strEmpRcx, fltValCar, fltChqVis, fltChqPre);
      fCommit;
      If Not fEmptyStr(strDocsNaoEnc) Then
        fMensagem('ATENÇÃO!', 'Não foram encontrados os ' + strDocsNaoEnc + '. Favor verificar.', ['&Ok']);
      
      fMensagem('', 'Duplicatas estornadas com sucesso!', ['&O k']);
      pLimpaCampos;

      FreeAndNil(qryGen);
    End
    Else
    Begin
      fRollBack;
    End;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      FreeAndNil(qryGen);
      pMensagensErro('Erro ao tentar estornar duplicatas:' + #13 + E.Message, '[pEstornaDuplicataConjug]');
    End;
  End;

end;

{******************************************************************************************}
{* TRAVA NOVA - PERMITI ESTORNAR QUANDO HA MAIS DE UMA DUPLICATA SOMENTE TODAS DE UMA VEZ *}
{***************************************************************************************LU*}
function TfrmEstornoCtaReceber.fCarregaCartoesTransferidos(intSeqCon: Integer;
  strEmpRcx: String): TUniQuery;
  Var
    strSQL: String;
begin
  Result := fCriaQuery(Self);
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  MCA_DTATRA, ';
  strSQL := strSQL + '  MCA_VALSTA ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVCAR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  MCA_SEQCON = :SEQCON AND ';
  strSQL := strSQL + '  MCA_EMPRCX = :EMPRCX AND ';
  strSQL := strSQL + '  MCA_DTATRA IS NOT NULL ';

  With Result, SQL Do
  Begin
    Close;
    Clear;
    Add(strSQL);
    ParamByName('SEQCON').AsInteger := intSeqCon;
    ParamByName('EMPRCX').AsString  := strEmpRcx;
    Open;
  End;
end;

function TfrmEstornoCtaReceber.fCarregaChequesTransferidos(intSeqCon: Integer;
  strEmpRcx: String): TUniQuery;
  Var
    strSQL: String;
begin
  Result := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CHQ_DTATRA, ';
  strSQL := strSQL + '  CHQ_VALCHQ, ';
  strSQL := strSQL + '  CHQ_DTACAD, ';
  strSQL := strSQL + '  CHQ_DTAVEN ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCHQ ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CHQ_SEQCON = :SEQCON AND ';
  strSQL := strSQL + '  CHQ_EMPRCX = :EMPRCX AND ';
  strSQL := strSQL + '  CHQ_DTATRA IS NOT NULL ';

  strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(strSql, 'CADCHQ', 'CADCHQX');

  With Result, SQL Do
  Begin
    Close;
    Clear;
    Add(strSQL);
    ParamByName('SEQCON').AsInteger := intSeqCon;
    ParamByName('EMPRCX').AsString  := strEmpRcx;
    Open;
  End;
end;

function TfrmEstornoCtaReceber.fChamaTelaConjugadas(strSeqCon, strEmpRcx: String;
  intResCai: Integer): Boolean;
begin
  Result := False;
  Try
    pCriarFormularios(TfrmEstDuplicatasConjug, frmEstDuplicatasConjug);
    frmEstDuplicatasConjug.strSeqCon := strSeqCon;
    frmEstDuplicatasConjug.strEmpRcx := strEmpRcx;
    frmEstDuplicatasConjug.intResCai := intResCai;
    frmEstDuplicatasConjug.showModal;
    Result := frmEstDuplicatasConjug.blnConfirma;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[ frmEstDuplicatasConjug ]');
    End;
  End;
  pFreeAndNil(frmEstDuplicatasConjug);

end;

function TfrmEstornoCtaReceber.fEstornaCheque(intSeqCon: Integer;
  strEmpRcx, strTipChq: String): Boolean;
  Var
    qryGen    : TUniQuery;
    qryAux    : TUniQuery;
    strSQL    : String;
    strSQLDel : String;
    blnTemChq : Boolean;
    arrLogChq1: TRegistroLogChq;
    arrLogChq2: TRegistroLogChq;

    function fChequeExiste(intCaixa: Integer): Boolean;
    begin
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  COUNT(*) AS QTD ';
      strSQL := strSQL + 'FROM ';

      If intCaixa = 1 Then
        strSQL := strSQL + '  CADCHQ '
      Else
        strSQL := strSQL + '  CADCHQX ';

      strSQL := strSQL + 'WHERE                      ';
      strSQL := strSQL + '   CHQ_SEQCON = :SEQCON AND ';
      strSQL := strSQL + '   CHQ_EMPRCX = :EMPRCX AND ';
      strSQL := strSQL + '   CHQ_DOCUME LIKE "%' + strTipChq + '" ';

      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);
      qryGen.ParamByName('SEQCON').AsInteger := intSeqCon;
      qryGen.ParamByName('EMPRCX').AsString  := strEmpRcx;
      qryGen.Open;
      Result := (qryGen.FieldByName('QTD').AsInteger > 0);
      qryGen.Close;
    end;
Begin

  If intSeqCon <= 0 Then
  Begin

    If Not fEmptyStr(strDocsNaoEnc) Then
      strDocsNaoEnc := strDocsNaoEnc + ' e/ou ';
      
    strDocsNaoEnc := strDocsNaoEnc + 'Cheques a ' + IIF(strTipChq = 'AVI', 'Vista', 'Prazo');

    Result := True;
    Exit;
  End;

  blnTemChq := False;

  qryGen := fCriaQuery;
  qryAux := fCriaQuery;
  
  {***********************}
  {* GRAVA NO DEL_CADCHQ *}
  {********************JU*}
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE * FROM ';
  strSQL := strSQL + '  CADCHQ ';
  strSQL := strSQL + ' WHERE                      ';
  strSQL := strSQL + '   CHQ_SEQCON = :SEQCON AND ';
  strSQL := strSQL + '   CHQ_EMPRCX = :EMPRCX AND ';
  strSQL := strSQL + '   CHQ_DOCUME LIKE "%' + strTipChq + '" ';

  If fChequeExiste(1) Then
  Begin
    strSQL := '';
    strSQL := strSQL +  ' SELECT * FROM         ';
    strSQL := strSQL +  '  CADCHQ ';
    strSQL := strSQL +  ' WHERE                      ';
    strSQL := strSQL +  '   CHQ_SEQCON = :SEQCON AND ';
    strSQL := strSQL +  '   CHQ_EMPRCX = :EMPRCX AND ';
    strSQL := strSQL +  '   CHQ_DOCUME LIKE "%' + strTipChq + '" ';

    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQCON').AsInteger := intSeqCon;
      ParamByName('EMPRCX').AsString  := strEmpRcx;
      Open;
      First;
      SetLength(arrLogChq1, 0);
    End;

    blnTemChq := True;
    With qryGen, SQL Do
    Begin
      Close;
      Clear;
      Add(strSQL);
      ParamByName('SEQCON').AsInteger := intSeqCon;
      ParamByName('EMPRCX').AsString  := strEmpRcx;
      Open;
    End;

    While Not qryAux.Eof Do
    Begin
      pLogChq(qryAux, 'CADCHQ', arrLogChq1);

      Next;
    End;

    fGravaLogChq(arrLogChq1);    
  End;

  fVerificaIntegridade(Self.Name, 'CADCHQ', qryGen);

  strSQL := AnsiReplaceStr(strSQL, 'CADCHQ', 'CADCHQX');

  If fChequeExiste(2) Then
  Begin
    strSQL := '';
    strSQL := strSQL +  ' SELECT * FROM         ';
    strSQL := strSQL +  '  CADCHQ ';
    strSQL := strSQL +  ' WHERE                      ';
    strSQL := strSQL +  '   CHQ_SEQCON = :SEQCON AND ';
    strSQL := strSQL +  '   CHQ_EMPRCX = :EMPRCX AND ';
    strSQL := strSQL +  '   CHQ_DOCUME LIKE "%' + strTipChq + '" ';

    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQCON').AsInteger := intSeqCon;
      ParamByName('EMPRCX').AsString  := strEmpRcx;
      Open;
      First;
      SetLength(arrLogChq2, 0);
    End;

    blnTemChq := True;
    With qryGen, Sql Do
    Begin
      Close;
      Clear;
      Add(strSQL);
      ParamByName('SEQCON').AsInteger := intSeqCon;
      ParamByName('EMPRCX').AsString  := strEmpRcx;
      Open;
    End;      

    While Not qryAux.Eof Do
    Begin
      pLogChq(qryAux, 'CADCHQX', arrLogChq2);

      Next;
    End;

    fGravaLogChq(arrLogChq2);
  End;

  fVerificaIntegridade(Self.Name, 'CADCHQX', qryGen);

  strSQLDel := '';
  strSQLDel := strSQLDel +  ' DELETE FROM         ';
  strSQLDel := strSQLDel +  '  CADCHQ ';
  strSQLDel := strSQLDel +  ' WHERE                      ';
  strSQLDel := strSQLDel +  '   CHQ_SEQCON = :SEQCON AND ';
  strSQLDel := strSQLDel +  '   CHQ_EMPRCX = :EMPRCX AND ';
  strSQLDel := strSQLDel +  '   CHQ_DOCUME LIKE "%' + strTipChq + '" ';

  If fChequeExiste(1) Then
  Begin
    blnTemChq := True;
    With qryGen, Sql Do
    Begin
      Close;
      Clear;
      Add(strSQLDel);
      ParamByName('SEQCON').AsInteger := intSeqCon;
      ParamByName('EMPRCX').AsString  := strEmpRcx;
      ExecSQL;
      Close;
    End;
  End;

  strSQLDel := AnsiReplaceStr(strSQLDel, 'CADCHQ', 'CADCHQX');

  If fChequeExiste(2) Then
  Begin
    blnTemChq := True;
    With qryGen, Sql Do
    Begin
      Close;
      Clear;
      Add(strSQLDel);
      ParamByName('SEQCON').AsInteger := intSeqCon;
      ParamByName('EMPRCX').AsString  := strEmpRcx;
      ExecSQL;
      Close;
    End;
  End;

  If (Not blnTemChq) Then
  Begin
    If Not fEmptyStr(strDocsNaoEnc) Then
      strDocsNaoEnc := strDocsNaoEnc + ' e/ou ';
      
    strDocsNaoEnc := strDocsNaoEnc + 'Cheques a ' + IIF(strTipChq = 'AVI', 'Vista', 'Prazo');
  End;

  FreeAndNil(qryGen);
  FreeAndNil(qryAux);
end;

function TfrmEstornoCtaReceber.fEstornaMovCar(strNumDup, strEspDoc,
  strParcel, strCodEmp: String; intSeqBai: Integer): Boolean;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin

  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL +  ' DELETE FROM MOVCAR         ';
    strSQL := strSQL +  ' WHERE                      ';
    strSQL := strSQL +  '   MCA_DOCUME = CONCAT(:NUMDUP,"-",:PARCEL,"-",:ESPDOC,"-",:CODEMP,"-",:SEQBAI) ';

    With qryGen, Sql Do
    Begin
      Close;
      Clear;
      Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('NUMDUP').AsString := strNumDup;
      ParamByName('PARCEL').AsString := strParcel;
      ParamByName('SEQBAI').AsString := fStrZero(IntToStr(intSeqBai),3);
      ExecSQL;
      Close;

      Result := True;
    End;

    FreeAndNil(qryGen);
  Except
    On E: Exception Do
    Begin
      Result := False;
      FreeAndNil(qryGen);
      pMensagensErro('Erro: ' + E.Message, '[fEstornaMovCar]');
    End;
  End;

end;

function TfrmEstornoCtaReceber.fEstornaCheque(strNumDup, strEspDoc,
  strParcel, strCodEmp: String): Boolean;
  Var
    qryGen: TUniQuery;
    qryAux: TUniQuery;
    strSQL: String;
    strAux: String;
    strDocume: String;
    intContador: Integer;
    arrLogChq  : TRegistroLogChq;
Begin

  strDocume := strNumDup + strParcel + strEspDoc + strCodEmp;

  Try
    qryGen := fCriaQuery;
    qryAux := fCriaQuery;

    {***********************}
    {* GRAVA NO DEL_CADCHQ *}
    {********************JU*}
    strSQL := '';
    strSQL := strSQL +  ' SELECT SQL_NO_CACHE * FROM  ';

    If (Pos(strEspDoc, 'NF_EL_NS_IF_D1_NV_') > 0) Then
      strSQL := strSQL +  '  CADCHQ '
    Else
      strSQL := strSQL +  '  CADCHQX ';

    strSQL := strSQL +  ' WHERE                      ';
    strSQL := strSQL +  '   CHQ_DOCUME = :DOCUME ';

    With qryGen, SQL Do
    Begin
      Close;
      Clear;
      Add(strSQL);
      ParamByName('DOCUME').AsString :=  strDocume + IIF(intContador = 1, 'AVI', 'PRZ');
      Open;
    End;

    fVerificaIntegridade(Self.Name, IIF(Pos(strEspDoc, 'NF_EL_NS_IF_D1_NV_') > 0, 'CADCHQ', 'CADCHQX'), qryGen);

    For intContador := 1 To 2 Do
    Begin
      strAux := '';
      strAux := strAux +  ' SELECT * FROM         ';

      If (Pos(strEspDoc, 'NF_EL_NS_IF_D1_NV_') > 0) Then
        strAux := strAux +  '  CADCHQ '
      Else
        strAux := strAux +  '  CADCHQX ';

      strAux := strAux +  ' WHERE                      ';
      strAux := strAux +  '   CHQ_DOCUME = :DOCUME ';

      With qryAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strAux);
        ParamByName('DOCUME').AsString  := strDocume + IIF(intContador = 1, 'AVI', 'PRZ');
        Open;
        First;
        SetLength(arrLogChq, 0);

        While Not Eof Do
        Begin
          fInsereLogChqArr(arrLogChq,
                           FieldByName('CHQ_CODBCO').AsString,
                           FieldByName('CHQ_NUMAGE').AsString,
                           FieldByName('CHQ_CONCOR').AsString,
                           FieldByName('CHQ_NUMCHQ').AsString,
                           FieldByName('CHQ_CODCLI').AsString,
                           FieldByName('CHQ_NOMEMI').AsString,
                           FieldByName('CHQ_ENDERE').AsString,
                           FieldByName('CHQ_TELEMI').AsString,
                           FieldByName('CHQ_CGCCPF').AsString,
                           FieldByName('CHQ_C_G_C_').AsString,
                           FieldByName('CHQ_DTACAD').AsDateTime,
                           FieldByName('CHQ_DTAVEN').AsDateTime,
                           FieldByName('CHQ_VALCHQ').AsFloat,
                           FieldByName('CHQ_HIST01').AsString,
                           FieldByName('CHQ_HIST02').AsString,
                           FieldByName('CHQ_CTADEP').AsString,
                           FieldByName('CHQ_DTADEP').AsDateTime,
                           FieldByName('CHQ_DOCDEP').AsString,
                           FieldByName('CHQ_CODPOR').AsString,
                           FieldByName('CHQ_CODCTA').AsString,
                           FieldByName('CHQ_DTADEV').AsDateTime,
                           FieldByName('CHQ_MOTDEV').AsString,
                           FieldByName('CHQ_DTARDP').AsDateTime,
                           FieldByName('CHQ_FORREP').AsString,
                           FieldByName('CHQ_OBSREP').AsString,
                           FieldByName('CHQ_DTAREP').AsDateTime,
                           FieldByName('CHQ_RESCAI').AsInteger,
                           FieldByName('CHQ_CODEMP').AsString,
                           FieldByName('CHQ_NUMNOT').AsString,
                           FieldByName('CHQ_DTACUS').AsDateTime,
                           FieldByName('CHQ_PORCUS').AsString,
                           FieldByName('CHQ_DOCUME').AsString,
                           FieldByName('CHQ_INCCTR').AsString,
                           FieldByName('CHQ_HISTOR').AsString,
                           FieldByName('CHQ_DOCCUS').AsString,
                           FieldByName('CHQ_LOTCUS').AsString,
                           FieldByName('CHQ_PORDEB').AsString,
                           FieldByName('CHQ_CTADEB').AsString,
                           FieldByName('CHQ_MOTDV2').AsString,
                           FieldByName('CHQ_DTADP2').AsDateTime,
                           FieldByName('CHQ_DTADV2').AsDateTime,
                           FieldByName('CHQ_SEQCOM').AsString,
                           FieldByName('CHQ_DTATRA').AsDateTime,
                           FieldByName('CHQ_SEQCON').AsInteger,
                           FieldByName('CHQ_EMPRCX').AsString,
                           'DELETANDO (frmEstornoCtaReceber.fEstornaCheque)',
                           IIF(Pos(strEspDoc, 'NF_EL_NS_IF_D1_NV_') > 0, 'CADCHQ', 'CADCHQX'),
                           FieldByName('CHQ_DEVDEF').AsInteger,
                           FieldByName('CHQ_CODVEN').AsString,
                           FieldByName('CHQ_SEQTRF').AsInteger,
                           FieldByName('CHQ_DUPDEV').AsString,
                           FieldByName('CHQ_DUPDEP').AsString,
                           FieldByName('CHQ_CTDPSV').AsString,
                           FieldByName('CHQ_CTDBSV').AsString,
                           FieldByName('CHQ_PRDBSV').AsString,
                           FieldByName('CHQ_CDCTSV').AsString,
                           FieldByName('CHQ_CDPRSV').AsString,
                           FieldByName('CHQ_TELCHE').AsString,
                           FieldByName('CHQ_TELNUM').AsString,
                           FieldByName('CHQ_SEQDEP').AsString,
                           FieldByName('CHQ_CODOPE').AsString,
                           FieldByName('CHQ_CODCMC').AsString);

          Next;
        End;

      End;
    End;

    fGravaLogChq(arrLogChq);

    strSQL := '';
    strSQL := strSQL +  ' DELETE FROM         ';
    
    If (Pos(strEspDoc, 'NF_EL_NS_IF_D1_NV_') > 0) Then
      strSQL := strSQL +  '  CADCHQ '
    Else
      strSQL := strSQL +  '  CADCHQX ';

    strSQL := strSQL +  ' WHERE                      ';
    strSQL := strSQL +  '   CHQ_DOCUME = :DOCUME ';

    For intContador := 1 To 2 Do
    Begin
      With qryGen, Sql Do
      Begin
        Close;
        Clear;
        Add(strSQL);
        ParamByName('DOCUME').AsString  := strDocume + IIF(intContador = 1, 'AVI', 'PRZ');
        ExecSQL;
        Close;
      End;
    End;

    Result := True;

    FreeAndNil(qryGen);
    FreeAndNil(qryAux);
  Except
    On E: Exception Do
    Begin
      Result := False;
      FreeAndNil(qryGen);
      pMensagensErro('Erro: ' + E.Message, '[fEstornaMovCar]');
    End;
  End;
end;

{***************************************************************}
{* ESTA FUNÇÃO VERIFICA SE EXISTEM CONTAS BAIXADAS COM O MESMO *}
{* (CTR_SEQCON + CTR_EMPBAI) COM DATAS DIFERENTES. SE HOUVER,  *}
{* NÃO DEIXA ESTORNAR A DUPLICATA E EXIBE MENSAGEM.            *}
{************************************************************RV*}
function TfrmEstornoCtaReceber.fVerificaDatasDiferentes(strSeqCon,
  strEmpRcx: String): Boolean;
  Var
    strSql: String;
    qryAux: TUniQuery;
begin
  Result := False;

  If (StrToIntDef(strSeqCon, 0) <= 0) Then
  Begin
    Result := True;
    Exit;
  End;

  strSql := '';
  strSql := strSql + ' SELECT SQL_NO_CACHE ';
  strSql := strSql + '   CTR_DTAREC ';
  strSql := strSql + ' FROM ';
  strSql := strSql + '   CADREC ';
  strSql := strSql + ' WHERE ';
  strSql := strSql + '   CTR_EMPBAI = :EMPBAI AND ';
  strSql := strSql + '   CTR_SEQCON = :SEQCON ';

  strSql := strSql + ' UNION ALL ' + AnsiReplaceStr(strSql, 'CADREC', 'CADRECX');

  strSql := ' SELECT ' +
            '   COUNT(DISTINCT CTR_DTAREC) AS QTD ' +
            ' FROM ' +
            '   (' + strSql + ') T ';

  qryAux := fCriaQuery(Self);

  With qryAux, SQL Do
  Begin
    Clear;
    Add(strSql);
    ParamByName('EMPBAI').AsString  := strEmpRcx;
    ParamByName('SEQCON').AsInteger := StrToInt(strSeqCon);
    Open;

    Result := (qryAux.FieldByName('QTD').AsInteger = 1);

    If Not Result Then
      fMensagem('ATENÇÃO!', 'Não é possível estornar esta Duplicata!' + #13 +
                            'Entre em contato com a Citel Software pois existem' + #13 +
                            'configurações a serem feitas antes da realização do estorno!' +#13 + #13 +
                            'Código: ' + strSeqCon + '-' + strEmpRcx, ['&O k']);
  End;

  FreeAndNil(qryAux);
end;

function TfrmEstornoCtaReceber.fVerificaDocumentosBaixados(strSeqCon,
  strEmpRcx: String): Boolean;
  Var
    qryCheques: TUniQuery;
    qryCartoes: TUniQuery;
    blnContinuar: Boolean;
begin

  Result := False;

  If StrToIntDef(strSeqCon, 0) <= 0 Then
  Begin
    Result := True;
    Exit;
  End;

  qryCartoes := fCriaQuery(Self);
  qryCheques := fCriaQuery(Self);

  qryCartoes.SQL.Clear;
  qryCartoes.SQL.Add('SELECT ');
  qryCartoes.SQL.Add('  CONCAT(MCA_NUMDUP, MCA_PARCEL) AS MCA_NUMDUP, ');
  qryCartoes.SQL.Add('  MCA_CODEMP, ');
  qryCartoes.SQL.Add('  CONCAT(MCA_CODCAR, "-", CAR_DESCAR) AS MCA_NOMCAR, ');
  qryCartoes.SQL.Add('  MCA_VALORI ');
  qryCartoes.SQL.Add('FROM ');
  qryCartoes.SQL.Add('  MOVCAR ');
  qryCartoes.SQL.Add('JOIN CADCAR ON CAR_CODCAR = MCA_CODCAR ');
  qryCartoes.SQL.Add('WHERE ');
  qryCartoes.SQL.Add('  MCA_SEQCON = :SEQCON AND ');
  qryCartoes.SQL.Add('  MCA_EMPRCX = :EMPRCX AND ');
  qryCartoes.SQL.Add('  MCA_DTAREC IS NOT NULL ');
  qryCartoes.SQL.Add('ORDER BY ');
  qryCartoes.SQL.Add('  MCA_CODEMP, MCA_NUMDUP, MCA_PARCEL ');

  qryCartoes.ParamByName('SEQCON').AsInteger := StrToInt(strSeqCon);
  qryCartoes.ParamByName('EMPRCX').AsString  := strEmpRcx;
  qryCartoes.Open;

  TFloatField(qryCartoes.FieldByName('MCA_VALORI')).DisplayFormat := '#,##0.00';

  qryCheques.SQL.Clear;
  qryCheques.SQL.Add('SELECT ');
  qryCheques.SQL.Add('  CHQ_CODBCO, ');
  qryCheques.SQL.Add('  CHQ_NUMAGE, ');
  qryCheques.SQL.Add('  CHQ_CONCOR, ');
  qryCheques.SQL.Add('  CHQ_NUMCHQ, ');
  qryCheques.SQL.Add('  CHQ_NOMEMI, ');
  qryCheques.SQL.Add('  CHQ_VALCHQ, ');
  qryCheques.SQL.Add('  RIGHT(CHQ_DOCUME, 3) AS CHQ_TIPCHQ ');
  qryCheques.SQL.Add('FROM ');
  qryCheques.SQL.Add('  CADCHQ ');
  qryCheques.SQL.Add('WHERE ');
  qryCheques.SQL.Add('  CHQ_SEQCON = :SEQCON AND ');
  qryCheques.SQL.Add('  CHQ_EMPRCX = :EMPRCX AND ');

  {******************************************}
  {* ATENÇÃO: ESSE FILTRO PARA VERIFICAR SE *}
  {* O CHEQUE ESTÁ BAIXADO FOI FEITO ASSIM  *}
  {* PROPOSITALMENTE.                       *}
  {***************************************MV*}
  qryCheques.SQL.Add('  CHQ_DTADEP IS NOT NULL ');

  qryCheques.SQL.Add(' UNION ALL ');

  qryCheques.SQL.Add('SELECT ');
  qryCheques.SQL.Add('  CHQ_CODBCO, ');
  qryCheques.SQL.Add('  CHQ_NUMAGE, ');
  qryCheques.SQL.Add('  CHQ_CONCOR, ');
  qryCheques.SQL.Add('  CHQ_NUMCHQ, ');
  qryCheques.SQL.Add('  CHQ_NOMEMI, ');
  qryCheques.SQL.Add('  CHQ_VALCHQ, ');
  qryCheques.SQL.Add('  RIGHT(CHQ_DOCUME, 3) AS CHQ_TIPCHQ ');
  qryCheques.SQL.Add('FROM ');
  qryCheques.SQL.Add('  CADCHQX ');
  qryCheques.SQL.Add('WHERE ');
  qryCheques.SQL.Add('  CHQ_SEQCON = :SEQCON AND ');
  qryCheques.SQL.Add('  CHQ_EMPRCX = :EMPRCX AND ');

  {******************************************}
  {* ATENÇÃO: ESSE FILTRO PARA VERIFICAR SE *}
  {* O CHEQUE ESTÁ BAIXADO FOI FEITO ASSIM  *}
  {* PROPOSITALMENTE.                       *}
  {***************************************MV*}
  qryCheques.SQL.Add('  CHQ_DTADEP IS NOT NULL ');

  qryCheques.ParamByName('SEQCON').AsInteger := StrToInt(strSeqCon);
  qryCheques.ParamByName('EMPRCX').AsString  := strEmpRcx;
  qryCheques.Open;

  TFloatField(qryCheques.FieldByName('CHQ_VALCHQ')).DisplayFormat := '#,##0.00';

  If (qryCheques.IsEmpty) And
     (qryCartoes.IsEmpty) Then
  Begin
    Result := True;
  End
  Else
  Begin
    blnContinuar := True;
    Try
      pCriarFormularios(TfrmFinDocsBaixados, frmFinDocsBaixados);
    Except
      On E: Exception Do
      Begin
        blnContinuar := False;
        pMensagensErro(E.Message, '[TfrmEstornoCtaReceber.fVerificaDocumentosBaixados_1]');
      End;
    End;

    If (blnContinuar) Then
    Begin
      Try
        frmFinDocsBaixados.dtsCartoes.DataSet := qryCartoes;
        frmFinDocsBaixados.dtsCheques.DataSet := qryCheques;
        frmFinDocsBaixados.ShowModal;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TfrmEstornoCtaReceber.fVerificaDocumentosBaixados_2]');
        End;
      End;
    End;

    pFreeAndNil(frmFinDocsBaixados);
  End;

  FreeAndNil(qryCartoes);
  FreeAndNil(qryCheques);

end;

procedure TfrmEstornoCtaReceber.pApagaChequeCartao(strSeqCon, strEmpRcx: String;
  fltValCar, fltChqVis, fltChqPre: Double);
begin
  If fFormataFloat(fltValCar, 2) > 0 Then
  Begin
    fEstornaMovCar(StrToInt(strSeqCon), strEmpRcx);
  End;

  If fFormataFloat(fltChqVis, 2) > 0 Then
  Begin
    fEstornaCheque(StrToInt(strSeqCon), strEmpRcx, 'AVI');
  End;

  If fFormataFloat(fltChqPre, 2) > 0 Then
  Begin
    fEstornaCheque(StrToInt(strSeqCon), strEmpRcx, 'PRZ');
  End;
end;

procedure TfrmEstornoCtaReceber.FormShow(Sender: TObject);
  Var
    dtaDtaFec: TDateTime;
    fltSalFec: Double;
begin
  inherited;
  {*************************************}
  {* VERIFICA SE O CAIXA ESTÁ FECHADO  *}
  {**********************************AF*}
  pRetornaUltimoFechamento(fltSalFec, dtaDtaFec);

  If (dtaDtaFec = VS_Date) Then
  Begin
    blnFecharForm := True;
  End;

  If dtaDtaRcx <= 0 Then
    dtaDtaRcx := VS_Date;
  
end;

procedure TfrmEstornoCtaReceber.FormPaint(Sender: TObject);
begin
  inherited;
  If (blnFecharForm) Then
    Close;
end;

procedure TfrmEstornoCtaReceber.pEstornarLancamentoCreditoCaixa(strNumDup,
  strParcel, strCodEmp, strEspDoc, strCodCli: String; intSeqBai: Integer;
  qryDuplicatas: TUniQuery; strPorBaiSelecionado: String);
  Var
    qryAux: TUniQuery;
    strAutInc: String;
    strPorBaiEstorno: String;
    strCtaBaiEstorno: String;
    dtaEstorn: TDateTime;

    function pDefinePortadorParaCredito: String;
      Var
        intRecNo: Integer;
    begin
      intRecNo := cdsDados.RecNo;
      strPorBaiEstorno := '';
      strCtaBaiEstorno := '';

      cdsDados.First;
      While (Not cdsDados.Eof) Do
      Begin
        If ((cdsDados.FieldByName('CTR_DTAREC').AsDateTime <> dtaDtaRcx) And
             (cdsDados.FieldByName('CTR_RESCAI').AsInteger  <> 0      )) Then
        Begin
          strPorBaiEstorno := IIF(Not fEmptyStr(cdsDados.FieldByName('CTR_PORBAI').AsString),
                              cdsDados.FieldByName('CTR_PORBAI').AsString,
                              strPorBaiSelecionado);

          strCtaBaiEstorno := cdsDados.FieldByName('CTR_CTABAI').AsString;
          Break;
        End;

        cdsDados.Next;
      End;

      cdsDados.RecNo := intRecNo;
    end;
begin
  dtaEstorn := 0;
  
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  * ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  CADRECX ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  CTR_NUMDUP = :NUMDUP AND ');
  qryAux.SQL.Add('  CTR_PARCEL = :PARCEL AND ');
  qryAux.SQL.Add('  CTR_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  CTR_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  CTR_CODCLI = :CODCLI AND ');
  qryAux.SQL.Add('  CTR_SEQBAI = :SEQBAI ');

  qryAux.ParamByName('NUMDUP').AsString  := strNumDup;
  qryAux.ParamByName('PARCEL').AsString  := strParcel;
  qryAux.ParamByName('CODEMP').AsString  := strCodEmp;
  qryAux.ParamByName('ESPDOC').AsString  := strEspDoc;
  qryAux.ParamByName('CODCLI').AsString  := strCodCli;
  qryAux.ParamByName('SEQBAI').AsInteger := intSeqBai;

  qryAux.Open;

  If (qryAux.IsEmpty) Then
  Begin
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  * ');
    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add('  CADREC ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  CTR_NUMDUP = :NUMDUP AND ');
    qryAux.SQL.Add('  CTR_PARCEL = :PARCEL AND ');
    qryAux.SQL.Add('  CTR_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('  CTR_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  CTR_CODCLI = :CODCLI AND ');
    qryAux.SQL.Add('  CTR_SEQBAI = :SEQBAI ');

    qryAux.ParamByName('NUMDUP').AsString  := strNumDup;
    qryAux.ParamByName('PARCEL').AsString  := strParcel;
    qryAux.ParamByName('CODEMP').AsString  := strCodEmp;
    qryAux.ParamByName('ESPDOC').AsString  := strEspDoc;
    qryAux.ParamByName('CODCLI').AsString  := strCodCli;
    qryAux.ParamByName('SEQBAI').AsInteger := intSeqBai;

    qryAux.Open;
  End;

  fVerificaIntegridade(Self.Name, 'CADRECX', qryAux, True, False, 'ESTORNO DE CRÉDITO CONJUGADO');

  pDefinePortadorParaCredito;

  If fCfgSisL('DTAOER') = '1' Then
    dtaEstorn := VS_Date
  Else
    dtaEstorn := qryAux.FieldByName('CTR_DTAREC').AsDateTime;  

  If fEmptyStr(strPorBaiEstorno) Then
  Begin
    fGravaCadRcx(strAutInc,
                 qryAux.FieldByName('CTR_CODCLI').AsString,
                 strLoginUsuarioLogado,
                 qryAux.FieldByName('CTR_NUMDUP').AsString,
                 'LD',
                 VS_strCodEmp,
                 VS_Date,
                 Time,
                 qryAux.FieldByName('CTR_NUMDUP').AsString,
                 qryAux.FieldByName('CTR_PARCEL').AsString,
                 'REF. ESTORNO DE CRÉDITO CONJUGADO',
                 '',
                 '',
                 '',
                 qryAux.FieldByName('CTR_VALDUP').AsFloat,
                 0.0,
                 0.0,
                 -qryDuplicatas.FieldByName('DINREC').AsFloat,
                 -qryDuplicatas.FieldByName('CHQAVI').AsFloat,
                 -qryDuplicatas.FieldByName('CHQPRE').AsFloat,
                 -qryDuplicatas.FieldByName('CARREC').AsFloat,
                 -qryDuplicatas.FieldByName('ORDREC').AsFloat,
                 qryAux.FieldByName('CTR_VALDUP').AsFloat,
                 -qryDuplicatas.FieldByName('VALFIN').AsFloat,
                 0.0,
                 0.0,
                 '',
                 StrToInt(fRetRcxCon),
                 qryAux.FieldByName('CTR_SEQBAI').AsInteger,
                 fCfgSisL('SQFCRX', varInteger),
                 qryAux.FieldByName('CTR_CODEMP').AsString,
                 '',
                 intCaixa,
                 fltTotGua,
                 fltTotDol,
                 fltTotEur,
                 fltTotPes,
                 fltTotRea);
  End
  Else
  Begin
    If fEmptyStr(fGravaMovBan('MOVBANX',
                              strCtaBaiEstorno,                             // Centro de Custo
                              strPorBaiEstorno,                             // Portador da Baixa
                              strLoginUsuarioLogado,                        // Operador da Baixa
                              dtaEstorn{VS_Date},                                      // Data do Lançamento
                              Time,                                         // Hora do Lançamento
                              qryAux.FieldByName('CTR_NUMDUP').AsString,    // Numero do Documento
                              'D',                                          // Credito / Debito
                              qryAux.FieldByName('CTR_CODEMP').AsString,    // Empresa da Baixa
                              qryAux.FieldByName('CTR_VALDUP').AsFloat,     // Valor Do Lançamento
                              'ESTORNO DE CRÉDITO CONJUGADO',               // Histórico 1
                              '',                                           // Histórico 2
                              qryAux.FieldByName('CTR_CODCLI').AsString,    // Cliente da Duplicata
                              '',                                           // Fornecedor da Duplicata
                              qryAux.FieldByName('CTR_NUMDUP').AsString,    // Número da Duplicata
                              0,                                            // Sequencial de Baixa
                              qryAux.FieldByName('CTR_PARCEL').AsString,    // Parcela da Duplicata
                              VS_strCodEmp,                                 // Empresa da Duplicata
                              '',                                           // Serie
                              '',                                           // Codigo do Evento
                              '')) Then
    Begin
      fMensagem('', 'Não foi possível gravar o movimento bancário!', ['&Ok']);
      Exit;
    End;
  End;

  qryAux.Close;
  qryAux.SQL.Clear;
  qryAux.SQL.Add('DELETE FROM CADRECX ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  CTR_NUMDUP = :NUMDUP AND ');
  qryAux.SQL.Add('  CTR_PARCEL = :PARCEL AND ');
  qryAux.SQL.Add('  CTR_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  CTR_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  CTR_CODCLI = :CODCLI AND ');
  qryAux.SQL.Add('  CTR_SEQBAI = :SEQBAI ');

  qryAux.ParamByName('NUMDUP').AsString  := strNumDup;
  qryAux.ParamByName('PARCEL').AsString  := strParcel;
  qryAux.ParamByName('CODEMP').AsString  := strCodEmp;
  qryAux.ParamByName('ESPDOC').AsString  := strEspDoc;
  qryAux.ParamByName('CODCLI').AsString  := strCodCli;
  qryAux.ParamByName('SEQBAI').AsInteger := intSeqBai;
  qryAux.ExecSQL;

  FreeAndNil(qryAux);


end;

procedure TfrmEstornoCtaReceber.pCarregaValoresParaguai(intSeqcon: Integer; strEmpBai: String);
  Var
    qryGen: TUniQuery;
Begin

  Try
    qryGen := fCriaQuery(Self);

    fltTotGua := 0;
    fltTotDol := 0;
    fltTotEur := 0;
    fltTotPes := 0;
    fltTotRea := 0;

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT * FROM CADRCXX WHERE RCX_SEQCON = :SEQCON AND RCX_EMPBAI = :EMPBAI');
    qryGen.ParamByName('SEQCON').AsInteger := intSeqcon;
    qryGen.ParamByName('EMPBAI').AsString  := strEmpBai;
    qryGen.Open;

    While Not qryGen.Eof Do
    Begin
      fltTotGua := fltTotGua + qryGen.FieldByName('RCX_TOTGUA').AsFloat;
      fltTotDol := fltTotDol + qryGen.FieldByName('RCX_TOTDOL').AsFloat;
      fltTotEur := fltTotEur + qryGen.FieldByName('RCX_TOTEUR').AsFloat;
      fltTotPes := fltTotPes + qryGen.FieldByName('RCX_TOTPES').AsFloat;
      fltTotRea := fltTotRea + qryGen.FieldByName('RCX_TOTREA').AsFloat;

      qryGen.Next;
    End;

    fltTotGua := -fltTotGua;
    fltTotDol := -fltTotDol;
    fltTotEur := -fltTotEur;
    fltTotPes := -fltTotPes;
    fltTotRea := -fltTotRea;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, 'TfrmEstornoCtaReceber.pCarregaValoresParaguai');
  End;

  FreeAndNil(qryGen);
End;

end.

