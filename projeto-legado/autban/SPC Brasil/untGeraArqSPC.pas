unit untGeraArqSPC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.StdCtrls, Vcl.ExtCtrls, untConsultas, System.StrUtils,
  EditFocus, Vcl.Mask, MaskEditFocus, frxClass, frxExportCSVTestabilidade, untTypesSistema,
  Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, BitBtnLockedIncrem, untFuncoesSimples, Uni, DB,
  dxScreenTip, cxClasses, dxCustomHint, cxHint, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls,
  dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, DateUtils;

type
  TfrmGeraArqSPC = class(TfrmPai)
    pnlFundo: TPanel;
    lblDtaFin: TLabel;
    lblDtaIni: TLabel;
    lblCodEmp: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    pnlTopo: TPanel;
    mskDtaIni1: TMaskEditFocus;
    mskDtaFin1: TMaskEditFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    edtEspDoc: TEditFocus;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    rdgTipDta: TRadioGroup;
    btnGerar: TBitBtnLocked;
    Label3: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    HintControler: TcxHintStyleController;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure btnGerarClick(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure rdgTipDtaExit(Sender: TObject);
    procedure rdgTipDtaEnter(Sender: TObject);
  private
    { Private declarations }
    qryCadEmp: TUniQuery;
    qryCadPor: TUniQuery;
  public
    { Public declarations }
    intOpcao: Integer;
    arrEmpresa: TConsultasArray;
    arrClientes: TConsultasArray;

    procedure pGeraDupSPCBrasil;
    procedure pShowHint(edtEdit: TEditFocus; strTitulo: String);
    procedure pHideHint;
    procedure pShowHintRadioGroup(rdgRadio: TRadioGroup; strTitulo: String);

    procedure ValidaBaixasParciaisDuplicatasJaRealizadasAExclusao(ADataset: TUniQuery);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmGeraArqSPC: TfrmGeraArqSPC;

implementation

{$R *.dfm}

uses untGeraArqSerasaSel, untGeraArqSPCSel, untConstantes;

procedure TfrmGeraArqSPC.btnGerarClick(Sender: TObject);
begin
  inherited;
  intOpcao := fMensagem(Application.Title,'Selecione INCLUSÃO para enviar ao SPC Brasil duplicatas para cobrança/liquidação ou EXCLUSÃO para informar ao SPC Brasil duplicatas que  devem ser canceladas.',['Inclusão','Exclusão']);

  if intOpcao = 1 then
  begin
    //Index = 1 -> RECEBIMENTO / Index = 3 -> ENVIO SPC
    if (rdgTipDta.ItemIndex = 1) or
       (rdgTipDta.ItemIndex = 3) then
    begin
      fMensagem('ATENÇÃO!','Filtro de data escolhido não pertence a opção de INCLUSÃO.',['&O K']);
      pSetFocus(mskDtaIni);
      Exit;
    end;
  end
  else
  begin
    //Index = 0 -> CADASTRO / Index = 2 -> VENCIMENTO
    if (rdgTipDta.ItemIndex = 0) or
       (rdgTipDta.ItemIndex = 2) then
    begin
      fMensagem('ATENÇÃO!','Filtro de data escolhido não pertence a opção de EXCLUSÃO.',['&O K']);
      pSetFocus(mskDtaIni);
      Exit;
    end;
  end;

  if not fValidaCampos(mskDtaIni) then
    Exit;
  if not fValidaCampos(mskDtaFin) then
    Exit;

  If Not fVerificaCampos Then
    Exit;

  If fTabelaExiste('TMP_GERSPC') Then
    fDropTable('TMP_GERSPC');


  {***********************************************************}
  {* DESABILITA O BOTÃO PARA O USUARIO NÃO CLICAR DUAS VEZES *}
  {********************************************************MO*}
  btnGerar.Enabled := False;
  pGeraDupSPCBrasil;
  btnGerar.Enabled := True;
  pSetFocus(mskDtaIni);
end;

procedure TfrmGeraArqSPC.edtCodCliExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtCodCli);
end;

procedure TfrmGeraArqSPC.edtCodCliKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {***************************KP**}

  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGeraArqSPC.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtCodEmp);
end;

procedure TfrmGeraArqSPC.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************MO*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, Nil, Nil, Key, arrEmpresa, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGeraArqSPC.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples,
                     Self,
                     edtCodPor,
                     TEditFocus(edtDesPor),
                     nil,
                     Key,
                     arrSel,
                     True,
                     'Consulta de Portadores',
                     '',
                     False,
                     False,
                     '',
                     False,
                     True) then
    Begin
      If fValidaCampos(edtCodPor) Then
        SelectNext((Sender As TWinControl), True, True);
    End;
  End;
end;

procedure TfrmGeraArqSPC.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadEmp := fCriaQuery(Self);
  qryCadPor := fCriaQuery(Self);
end;

procedure TfrmGeraArqSPC.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If ActiveControl Is TRadioButton Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmGeraArqSPC.FormShow(Sender: TObject);
begin
  inherited;
  mskDtaIni.Text  := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text  := FormatDateTime('dd/mm/yyyy',VS_Date);
  pSetFocus(mskDtaIni);
end;

function TfrmGeraArqSPC.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
Var blnEmpMul: Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If Sender = edtCodEmp Then
    Begin
      If Result Then
      Begin
        blnEmpMul := (edtCodEmp.Text = '000') And (Length(arrEmpresa) > 0);
        If fEmptyStr(edtCodEmp.Text) Then
        Begin
          edtNomEmp.Text := 'TODAS';
          SetLength(arrEmpresa, 0);
        End
        Else If blnEmpMul Then
          edtNomEmp.Text := '+1'
        Else
        Begin
          edtCodEmp.Text := fStrZero(edtCodEmp.Text,3);
          edtNomEmp.Text := fRetNomeEmpresa(fStrZero(edtCodEmp.Text,3));
        End;

        If fEmptyStr(edtNomEmp.Text) And (Not fEmptyStr(edtCodEmp.Text)) Then
        Begin
          fMensagem('','Código da empresa não encontrado.',['&O K']);
          Result := False;
        End
        Else If (Not fEmptyStr(edtCodEmp.Text)) And (Not blnEmpMul)
        And (Pos(edtCodEmp.Text, fRetEmpAcessoCTR(strLoginUsuarioLogado)) <= 0) Then
        Begin
          fMensagem('','O usuário não possui permissão para utilizar a empresa selecionada!.',['&O K']);
          Result := False;
        End;
      End;
    End

    Else If Sender = edtCodCli Then
    Begin
      If Result Then
      Begin
        If fEmptyStr(edtCodCli.Text) Then
        Begin
          edtNomCli.Text := 'TODOS';
          SetLength(arrClientes, 0);
        End
        Else
        Begin
          edtCodCli.Text := fStrZero(edtCodCli.Text,8);
          edtNomcli.Text := fRetNomCliente(fStrZero(edtCodCli.Text,8));
        End;

        If fEmptyStr(edtNomCli.Text) And (Not fEmptyStr(edtCodCli.Text)) Then
        Begin
          fMensagem('','Cliente não cadastrado.',['&O K']);
          Result := False;
        End;
      End;
    End

    Else
     If(StrToDate(mskDtaIni.Text) < IncYear(VS_Date, -1)) And Not(ActiveControl.Name = btnGerar.Name) And mskDtaIni.Focused Then
      Begin
        Result := fMensagem('', 'Data inferior a ' + DateToStr(IncYear(VS_Date, -1)) + ' (1 ano). Deseja continuar?',
        ['&Sim', '&Não']) = 1;
      End;

      If(StrToDate(mskDtaFin.Text) < IncYear(VS_Date, -1)) And Not(ActiveControl.Name = btnGerar.Name) And mskDtaFin.Focused Then
      Begin
        Result := fMensagem('', 'Data inferior a ' + DateToStr(IncYear(VS_Date, -1)) + ' (1 ano). Deseja continuar?',
        ['&Sim', '&Não']) = 1;
      End;
    If Sender = mskDtaIni Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          fMensagem('','O período não deve ficar em branco!',['&O K'])
        Else
          fMensagem('','A data inicial deve ser preenchida!',['&O K']);
        Result := False;
      End;

    End

    Else If Sender = mskDtaFin Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('','A data final deve ser preenchida',['&O K']);
        Result := False;
      End
      Else If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
      Begin
        fMensagem('','A data inicial não pode ser maior que a data final!',['&O K']);
        Result := False;
      End
      Else If StrToDate(mskDtaFin.Text) > Date Then
      Begin
        fMensagem('','A data final não pode ser maior que hoje!',['&O K']);
        mskDtaFin.Text := FormatDateTime('dd/mm/yyyy', Date);
        Result := False;
      End;
    End

    Else If (Sender = edtCodPor) Then
    Begin
      If fEmptyStr(edtCodPor.Text) Then
        edtDesPor.Text := 'TODOS'
      Else
      Begin
        edtDesPor.Text := fRetNomPortador(edtCodPor.Text);

        If Not CarregaPortador(edtCodPor.Text) Then
           Result := False
        Else
        If fEmptyStr(edtDesPor.Text) And (Not fEmptyStr(edtCodPor.Text)) Then
        Begin
          fMensagem('','Código do portador não encontrado.',['&O K']);
          Result := False;
        End
        Else
        Begin
          {*REQ*145940**********RP*}
          If Not fEmptyStr(edtCodEmp.Text) And Not fEmpresaTemAcessoPortador(edtCodPor.Text, edtCodEmp.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End
          Else If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&O K']);
              Result := False;
            End;
          End;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmGeraArqSPC.pGeraDupSPCBrasil;
  Var
    strSQL, strMotivoExclusao: String;
    qryArqSer: TUniQuery;
    strEmpAce: String;
    recItem : TConsultas;
    intCont : Integer;

    LFiltraParcialExclusao: Boolean;
begin

  If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Or
     (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
  Begin
    fMensagem('','Data inicial e data final devem ser informadas!', ['&Ok']);
    pSetFocus(mskDtaIni);
    Exit;
  End;

  {********************************}
  {* SELECT PUXANDO AS INFORMACOES*}
  {* DE CADREC DE ACORDO COM      *}
  {* O FILTRO INFORMADO PELO      *}
  {* USUARIO                      *}
  {*****************************MO*}
  strMotivoExclusao := '';
  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIGSPC', 'MOTISPC', '')) Then
  Begin
    For intCont := Low(ARR_OCORRENCIA_SPCBRASIL) To High(ARR_OCORRENCIA_SPCBRASIL) Do
    begin
      if (ARR_OCORRENCIA_SPCBRASIL[intCont][0] = Copy(fGetBancoConfig(0, 'CONFIGSPC', 'MOTISPC', ''),1 ,02)) then
      begin
        strMotivoExclusao := ARR_OCORRENCIA_SPCBRASIL[intCont][1];
      end;
    end;
  End;

  LFiltraParcialExclusao := fGetBancoConfig(0, 'CONFIGSPC', 'PARCEXC', '') = 'S';
  If intOpcao = 1 Then
    LFiltraParcialExclusao := False;

  strSQL := '';
  strSQL := strSQL + 'SELECT DISTINCT ';
  strSQL := strSQL + 'CONCAT(CTR_NUMDUP,CTR_PARCEL) AS CTR_NUMDUP1, CTR_NUMDUP, CTR_PARCEL, CTR_ESPDOC, CTR_DTACAD, CTR_DTAREC, ';
  strSQL := strSQL + '       CAST(IF(IFNULL(CTR_DTAREC, "") = "", CTR_DTACAD, CTR_DTAREC) AS DATE) AS DTAREF, ';
  strSQL := strSQL + '       IF(CTR_SEQBAI = 0, CTR_VALORI, CTR_GRVORI) AS CTR_VALDUP, ';
  strSQL := strSQL + '       CONCAT(CTR_CODCLI, "-", CLI_NOMCLI) AS CTR_CLIENTE, CTR_CODCLI, CLI_NOMCLI, ';
  strSQL := strSQL + '       CONCAT(CTR_CODEVE, "-", EVE_DESEVE) AS CTR_CODEVE, POR_NOMPOR, CTR_NOSNUM, ';
  strSQL := strSQL + '       CTR_HIST01, CTR_HIST02, CTR_OBSAG1, CTR_OBSAG2, CTR_CODEMP, CTR_CODPOR, ';
  strSQL := strSQL + '       CTR_OBSAG3, CTR_CODVEL, CTR_DTAVEN, "D" AS CTR_MARCAD, "N" AS CTR_PROTES, ';
  strSQL := strSQL + '       CTR_DTASER, CTR_SEQBAI, CLI_CGCCPF, REPLACE(REPLACE(REPLACE(CLI_C_G_C_, ".", ""), "/", ""), "-", "") AS CLI_C_G_C_, ';
  strSQL := strSQL + '       CLI_DTACAD, CLI_STATUS, "NÃO" AS CTR_CANCEL, IF(DET_DOCDEV IS NULL, "NÃO", "SIM") AS DET_DEVOLV, CAST( "'+ strMotivoExclusao+ '" AS CHAR(50)) OCORRENCIA, ';
  strSQL := strSQL + '       CTR_STSSPC ';
  strSQL := strSQL + 'FROM CADREC ';
  strSQL := strSQL + 'LEFT JOIN CADEVE ON CTR_CODEVE = EVE_CODEVE ';
  strSQL := strSQL + 'LEFT JOIN CADCLI ON CTR_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + 'LEFT JOIN CADPOR ON CTR_CODPOR = POR_CODPOR ';
  strSQL := strSQL + 'LEFT JOIN MOVDET ON CTR_CODCLI = DET_CODCLI AND ';
  strSQL := strSQL + '                    CTR_NUMDUP = DET_DOCDEV AND ';
  strSQL := strSQL + '                    CTR_ESPDOC = DET_ESPDEV AND ';
  strSQL := strSQL + '                    CTR_CODEMP = DET_EMPDEV ';
  strSQL := strSQL + 'WHERE ';

  case rdgTipDta.ItemIndex of
    0: strSQL := strSQL + '  CTR_DTACAD BETWEEN :DTAINI AND :DTAFIM  ';
    1: strSQL := strSQL + '  CTR_DTAREC BETWEEN :DTAINI AND :DTAFIM  ';
    2: strSQL := strSQL + '  CTR_DTAVEN BETWEEN :DTAINI AND :DTAFIM  ';
    3: strSQL := strSQL + '  CTR_DTASPC BETWEEN :DTAINI AND :DTAFIM  ';
  end;

  if not fEmptyStr(edtCodCli.Text) then
    strSQL := strSQL + '  AND CTR_CODCLI = :CODCLI  ';

  //FILTRAR SOMENTE DUPLICATAS QUE ESTEJAM VENCIDAS
  strSQL := strSQL + '  AND CTR_DTAVEN < CURRENT_DATE  ';

  If (intOpcao = 1) Then
  BEGIN
    {******************************************************************************}
    {***** INCLUSÃO DE DUPLICATAS QUE NÃO FORAM ENVIADAS AINDA PARA O SPC OU ******}
    {* DE DUPLICATAS JÁ ENVIADAS E CONFIRMADAS COM STATUS 'E'. NAS DUAS SITUAÇÕES *}
    {****************** AS DUPLICATAS NÃO DEVEM ESTAR RECEBIDAS. ******************}
    {***************************************************************************MO*}
    strSQL := strSQL + ' AND ((CTR_DTAREC IS NULL AND CTR_DTASPC IS NULL AND CTR_DTCSPC IS NULL) OR  ';
    strSQL := strSQL + '     (CTR_DTAREC IS NULL AND CTR_DTASPC IS NOT NULL AND CTR_DTCSPC IS NOT NULL AND CTR_STSSPC = "E")) ';
  END
  Else
  BEGIN
    {***********************************************************************************}
    {*** EXCLUSÃO DE DUPLICATAS QUE JÁ FORAM GERADAS ARQUIVOS, JÁ FORAM CONFIRMADAS E **)
    {* STATUS "I". OU SEJA, SOMENTE SERÁ LISTADAS DUPLICATAS CONFIRMADAS COMO INCLUSÃO *}
    {********************************************************************************MO*}
    strSQL := strSQL + ' AND (CTR_DTASPC IS NOT NULL OR CTR_DTCSPC IS NOT NULL) AND CTR_STSSPC = "I" ';
  END;

  If Not LFiltraParcialExclusao Then
    strSQL := strSQL + ' AND CTR_SEQBAI = 0                            ';

  //Não mostrar os créditos
  strSQL := strSQL + ' AND CTR_VALORI > 0                              ';

  If (Not fEmptyStr(edtCodEmp.Text)) And (edtCodEmp.Text <> '000') Then
    strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP '
  Else
  Begin
    If Length(arrEmpresa) > 0 Then
    Begin
      strEmpAce := '';
      For recItem in arrEmpresa Do
        strEmpAce := strEmpAce + recItem.strCodigo + '_';
      strSQL := strSQL + '  AND LOCATE(CTR_CODEMP, ' + QuotedStr(strEmpAce) + ') > 0 ';
    End
    Else
      strSQL := strSQL + '  AND LOCATE(CTR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
  End;

  If Trim(edtEspDoc.Text) <> '' Then
    strSQL := strSQL + ' AND CTR_ESPDOC = :ESPDOC                      ';

  If Trim(edtCodPor.Text) <> '' Then
    strSQL := strSQL + ' AND CTR_CODPOR = :CODPOR                      '
  Else If fCfgSis('DACPOR', varBoolean) Then
  Begin
    strSQL := strSQL + ' AND (IFNULL(CTR_CODPOR, "") = "" ';
    strSQL := strSQL + ' OR LOCATE(CTR_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
  End;

  If intOpcao = 2 Then
  BEGIN
    strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(strSQL, 'CADREC', 'DEL_CADREC');
    strSQL := strSQL + ' AND CTR_NOMFRM <> "frmAgrupDuplicatas" ';
  END;

  strSQL := strSQL + ' GROUP BY CTR_NUMDUP, CTR_PARCEL, CTR_ESPDOC, CTR_CODEMP, CTR_CODCLI ';

  {*************************************************************}
  {* CRIA TABELA TEMPORARIA COM O RESULTADO PARA MELHOR OPERAR *}
  {**********************************************************MO*}

  qryArqSer := fCriaQuery(Self);

  qryArqSer.Close;
  qryArqSer.SQL.Clear;
  qryArqSer.SQL.Add('CREATE TEMPORARY TABLE TMP_GERSPC ' + strSQL);
  qryArqSer.ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
  qryArqSer.ParamByName('DTAFIM').AsDate := StrToDate(mskDtaFin.Text);

  If (Not fEmptyStr(edtCodEmp.Text)) Then
  Begin
    If (edtCodEmp.Text <> '000') Then
      qryArqSer.ParamByName('CODEMP').AsString := edtCodEmp.Text;
  End;

  If Trim(edtEspDoc.Text) <> '' Then
    qryArqSer.ParamByName('ESPDOC').AsString := edtEspDoc.Text;

  If (Not fEmptyStr(edtCodPor.Text)) Then
    qryArqSer.ParamByName('CODPOR').AsString := edtCodPor.Text;

  if not fEmptyStr(edtCodCli.Text) then
    qryArqSer.ParamByName('CODCLI').AsString := edtCodCli.Text;

  qryArqSer.ExecSQL;

  qryArqSer.SQL.Clear;
  qryArqSer.SQL.Add('SELECT * FROM TMP_GERSPC ORDER BY CTR_DTAVEN');
  qryArqSer.Options.SetFieldsReadOnly := False;
  qryArqSer.Open;

  (qryArqSer.FieldByName('CTR_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';

  ValidaBaixasParciaisDuplicatasJaRealizadasAExclusao(qryArqSer);

  If Not qryArqSer.IsEmpty Then
  Begin
    Try
      pCriarFormularios(TfrmGeraArqSPCSel, frmGeraArqSPCSel);
      frmGeraArqSPCSel.intOpcao  := intOpcao;
      frmGeraArqSPCSel.qryArqSPC := qryArqSer;
      frmGeraArqSPCSel.dtaDtaIni := StrToDate(mskDtaIni.Text);
      frmGeraArqSPCSel.dtaDtaFin := StrToDate(mskDtaFin.Text);
      frmGeraArqSPCSel.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, 'TfrmGeraArqSPC.pGeraDupSPC');
    End;
    pFreeAndNil(frmGeraArqSPCSel);
  End
  Else
    fMensagem('','Não há duplicatas para serem enviadas!', ['&OK']);

  FreeAndNil(qryArqSer);
end;

procedure TfrmGeraArqSPC.pHideHint;
begin
  HintControler.HideHint;
end;

procedure TfrmGeraArqSPC.pShowHint(edtEdit: TEditFocus; strTitulo: String);
begin
  HintControler.ShowHint(edtEdit.ClientOrigin.X,edtEdit.ClientOrigin.Y, strTitulo, edtEdit.Hint);
end;

procedure TfrmGeraArqSPC.pShowHintRadioGroup(rdgRadio: TRadioGroup; strTitulo: String);
begin
  HintControler.ShowHint(rdgRadio.ClientOrigin.X,rdgRadio.ClientOrigin.Y, strTitulo, rdgRadio.Hint);
end;

procedure TfrmGeraArqSPC.rdgTipDtaEnter(Sender: TObject);
begin
  inherited;
  rdgTipDta.Hint := 'Datas de Cadastro e Vencimento somente para inclusão. ' + #13+#10 +
                    'Datas de Recebimento e Envio SPC somente para exclusão.';
  pShowHintRadioGroup(rdgTipDta, 'Tipo de Data.');
end;

procedure TfrmGeraArqSPC.rdgTipDtaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmGeraArqSPC.ValidaBaixasParciaisDuplicatasJaRealizadasAExclusao(
  ADataset: TUniQuery);
begin
  If intOpcao = 1 THen
    Exit;

  If fGetBancoConfig(0, 'CONFIGSPC', 'PARCEXC', 'N') <> 'S' Then
    Exit;

  Try
    ADataset.Filter := 'CTR_SEQBAI > 0';
    ADataset.Filtered := True;

    While Not ADataset.Eof Do
    Begin
      If fCampoTabela('CTR_STSSPC',
                      'CADREC',
                      ['CTR_NUMDUP', 'CTR_PARCEL', 'CTR_ESPDOC', 'CTR_CODEMP', 'CTR_CODCLI', 'CTR_SEQBAI'],
                      [ADataset.FieldByName('CTR_NUMDUP').AsString,
                       ADataset.FieldByName('CTR_PARCEL').AsString,
                       ADataset.FieldByName('CTR_ESPDOC').AsString,
                       ADataset.FieldByName('CTR_CODEMP').AsString,
                       ADataset.FieldByName('CTR_CODCLI').AsString,
                       0]) = 'E' Then
      Begin
        ADataset.Delete;
        Continue;
      End;

      ADataset.Next;
    End;
  Finally
    ADataset.Filtered := False;
    ADataset.Filter := '';

    ADataset.First;
  End;
end;

end.
