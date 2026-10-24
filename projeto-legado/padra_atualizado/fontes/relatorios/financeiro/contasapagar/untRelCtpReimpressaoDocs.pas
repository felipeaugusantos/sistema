unit untRelCtpReimpressaoDocs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, MaskEditFocus, StdCtrls, EditFocus, AppEvnts, Menus,
  Buttons, ExtCtrls, StrUtils, Uni, BitBtnLockedIncrem, UniDataSetProvider,
  untTypesSistema, frxClass, frxExportCSVTestabilidade, untIFuncoes, UniClientDataSet,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar;

type
  TfrmRelCtpReimpressaoDoc = class(TfrmPai)
    pnlFundo: TPanel;
    Label1: TLabel;
    Label11: TLabel;
    lblDesDtaIni: TLabel;
    lblDesDtaFin: TLabel;
    Label12: TLabel;
    lblEmpresa: TLabel;
    Label2: TLabel;
    edtNumDoc: TEditFocus;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtCodFor: TEditFocus;
    edtDesFor: TEditFocus;
    btnImprimir: TBitBtnLocked;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtNumDocChange(Sender: TObject);
  private
    { Private declarations }
    intQtdReg: Integer;
    arrEmp   : TConsultasArray;
    arrFor   : TConsultasArray;
  public
    { Public declarations }
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelCtpReimpressaoDoc: TfrmRelCtpReimpressaoDoc;

implementation

uses DB,untRelCtpReimpressaoDocsList, untFuncoesSimples, untFuncoes, untConsultas;

{$R *.dfm}

{ TfrmRelCtpReimpressaoDoc }

procedure TfrmRelCtpReimpressaoDoc.btnImprimirClick(Sender: TObject);
  Var
    strSQL    : String;
    qryGenCtp : TUniQuery;
    dspGenCtp : TUniDataSetProvider;
    cdsGenCtp : TUniClientDataSet;
    frmRelCtpReimpressaoDocsList: TfrmRelCtpReimpressaoDocsList;

  function fTemLayoutPersonalizado: Boolean;
    Var
      strSQL   : String;
      qryLayImp: TUniQuery;
  Begin

    qryLayImp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT COUNT(*) AS CONT     ';
    strSQL := strSQL + ' FROM LAYIMP                 ';
    strSQL := strSQL + ' WHERE                       ';
    strSQL := strSQL + '   LAY_CODLAY = "RECCTP" AND ';

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + ' LAY_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + ' LOCATE(LAY_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    With qryLayImp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

      Open;
    End;

    Result := qryLayImp.FieldByName('CONT').AsInteger > 0;

    FreeAndNil(qryLayImp);

  End;

begin
  inherited;

    qryGenCtp := fCriaQuery(Self);

    cdsGenCtp := TUniClientDataSet.Create(Self);
    dspGenCtp := TUniDataSetProvider.Create(Self);
    dspGenCtp.DataSet := qryGenCtp;
    cdsGenCtp.SetProvider(dspGenCtp);

    btnImprimir.Enabled := False;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    (***********************************************************************)
    (* CAMPOS PARA A FUNÇÃO frmQckReimpCtaPagar.pImprimeRecibo - INICIO *)
    (********************************************************************LA*)
    strSQL := strSQL + '  CONCAT(CTP_NUMDUP,CTP_PARCEL) AS NUMDUP, ';
    strSQL := strSQL + '  CTP_HIST01 AS HIST01, ';
    strSQL := strSQL + '  CTP_HIST02 AS HIST02, ';
    strSQL := strSQL + '  IF(CTP_RESCAI <> 1, CTP_DTAVEN, CTP_DTABAI) AS DTAVEN, ';
    strSQL := strSQL + '  CTP_DTAPAG AS DTAPAG, ';
    strSQL := strSQL + '  CTP_VALORI AS VALDUP, '; //RENOMEADO PARA VALDUP POIS NA BAIXA SO USA O VALDUP
    strSQL := strSQL + '  CTP_VALPAG AS VALPAG, ';
    strSQL := strSQL + '  CTP_VALDES AS VALDES, ';
    strSQL := strSQL + '  CTP_VALJUR AS VALJUR, ';
    strSQL := strSQL + '  CTP_CODFOR AS CODFOR, ';
    strSQL := strSQL + '  CTP_SEQCON AS SEQCON, ';
    strSQL := strSQL + '  FOR_NOMFOR AS NOMFOR, ';
    strSQL := strSQL + '  FOR_FONE01 AS FONE01, ';
    strSQL := strSQL + '  FOR_F_A_X_ AS F_A_X_, ';
    {
    strSQL := strSQL + '  EMI_CODBCO AS CODBCO, ';
    strSQL := strSQL + '  EMI_NUMAGE AS NUMAGE, ';
    strSQL := strSQL + '  EMI_CONCOR AS CONCOR, ';
    strSQL := strSQL + '  EMI_NUMCHQ AS NUMCHQ, ';
    strSQL := strSQL + '  EMI_FAVORE AS FAVORE, ';
    strSQL := strSQL + '  EMI_BOMPAR AS BOMPAR, ';
    }
    (********************************************************************)
    (* CAMPOS PARA A FUNÇÃO frmQckReimpCtaPagar.pImprimeRecibo - FIM    *)
    (*****************************************************************JU*)

    strSQL := strSQL + '  CTP_NUMDUP AS CTP_NUMDUP, ';
    strSQL := strSQL + '  CTP_HIST01 AS CTP_HIST01, ';
    strSQL := strSQL + '  CTP_HIST02 AS CTP_HIST02, ';
    strSQL := strSQL + '  CTP_SEQBAI AS CTP_SEQBAI, ';
    strSQL := strSQL + '  CTP_PARCEL AS CTP_PARCEL, ';
    strSQL := strSQL + '  CTP_DTAVEN AS CTP_DTAVEN, ';
    strSQL := strSQL + '  CTP_VALORI AS CTP_VALDUP, '; //RENOMEADO PARA VALDUP POIS NA BAIXA SO USA O VALDUP
    strSQL := strSQL + '  CTP_DTACAD AS CTP_DTACAD, ';
    strSQL := strSQL + '  CTP_CODEMP AS CTP_CODEMP, ';
    strSQL := strSQL + '  CTP_VALPAG AS CTP_VALPAG, ';
    strSQL := strSQL + '  CTP_VALDES AS CTP_VALDES, ';
    strSQL := strSQL + '  CTP_VALJUR AS CTP_VALJUR, ';
    strSQL := strSQL + '  CTP_CODFOR AS CTP_CODFOR, ';
    strSQL := strSQL + '  FOR_NOMFOR AS FOR_NOMFOR, ';
    strSQL := strSQL + '  FOR_FONE01 AS FOR_FONE01, ';
    strSQL := strSQL + '  FOR_F_A_X_ AS FOR_F_A_X_, ';
    strSQL := strSQL + '  CTP_SEQCON AS CTP_SEQCON, ';
    strSQL := strSQL + '  (CTP_VALDUP + IFNULL(CTP_JURSUJ,0) + IFNULL(CTP_VENDOR,0)) -IFNULL(CTP_DESSUJ,0) AS TOTDUP, ';
    strSQL := strSQL + '  CTP_VALORI, ';
    strSQL := strSQL + '  V.EVE_DESEVE, ';
    strSQL := strSQL + '  B.POR_NOMPOR, ';
    strSQL := strSQL + '  CTP_USACHQ, ';
    strSQL := strSQL + '  CTP_CODEVE, ';
    strSQL := strSQL + '  CTP_PORBAI, ';
    strSQL := strSQL + '  CTP_SERIE_, ';
    strSQL := strSQL + '  CTP_TIPDOC, ';
    strSQL := strSQL + '  CTP_DESSUJ, ';
    strSQL := strSQL + '  CTP_JURSUJ, ';
    strSQL := strSQL + '  CTP_VENDOR, ';
    strSQL := strSQL + '  CTP_CODCTA, ';
    strSQL := strSQL + '  CTA_DESCTA, ';
    strSQL := strSQL + '  FOR_C_G_C_, ';
    strSQL := strSQL + '  CTP_CODVEL, ';
    strSQL := strSQL + '  CTP_PREVIS, ';
    strSQL := strSQL + '  CTP_VEIOBO, ';
    strSQL := strSQL + '  CONCAT(CTP_CODFOR ,"-", FOR_NOMFOR) AS CTP_NOMFOR, ';
    strSQL := strSQL + '  EMP_NOMEMP, ';
    strSQL := strSQL + '  CTP_EMPBAI AS EMPBAI, ';
    strSQL := strSQL + '  CTP_HISBAI, ';
    strSQL := strSQL + '  CTP_DINHEI, ';
    strSQL := strSQL + '  CTP_CHQAVI, ';
    strSQL := strSQL + '  CTP_CHQPRE, ';
    strSQL := strSQL + '  CTP_CARTAO, ';
    strSQL := strSQL + '  CTP_ORDPAG, ';
    strSQL := strSQL + '  CTP_REPCHQ, ';
    strSQL := strSQL + '  IF(CTP_RESCAI <> 1, "", (SELECT RCX_CODCAX FROM CADRCXX ';
    strSQL := strSQL + '                           WHERE RCX_SEQCON=CTP_RCXCON AND RCX_CODEMP=CTP_EMPBAI LIMIT 1)) AS RCX_CODCAX, ';

    strSQL := strSQL + '  CTP_RESCAI, ';
    strSQL := strSQL + '  FOR_CODFOR AS CODCLI, ';
    strSQL := strSQL + '  CONCAT(FOR_NOMFOR, " - ", CAST(IFNULL(CTP_HIST01, "") AS CHAR(255) ) ) AS DESCRI, ';
    strSQL := strSQL + '  "PG"       AS ESPDOC, ';
    strSQL := strSQL + '  "N"        AS RECPIX, ';
    strSQL := strSQL + '  CTP_NUMDOC AS NUMDOC, ';
    strSQL := strSQL + '  CTP_PARCEL AS PARCEL, ';
    strSQL := strSQL + '  CTP_VALORI AS VALDOC, ';
    strSQL := strSQL + '  CTP_VALPAG AS VALREC, ';
    strSQL := strSQL + '  CTP_RCXCON          , ';
    strSQL := strSQL + '  ""         AS RCX_CAIXA, ';
    strSQL := strSQL + '  CTP_DTABAI AS DTAREC, ';
    strSQL := strSQL + '  ""         AS CODVEN, ';
    strSQL := strSQL + '  CTP_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  CTP_CODCTA AS CODCTA, ';
    strSQL := strSQL + '  CTA_DESCTA AS DESCTA, ';
    strSQL := strSQL + '  ""         AS NOSNUM, ';
    strSQL := strSQL + '  (SELECT MAX(CTP_HORLOG) FROM LOGCTP LOG ';
    strSQL := strSQL + '   WHERE LOG.CTP_NUMDUP = CADPAG.CTP_NUMDUP  ';
    strSQL := strSQL + '   AND LOG.CTP_PARCEL = CADPAG.CTP_PARCEL  ';
    strSQL := strSQL + '   AND LOG.CTP_CODEMP = CADPAG.CTP_CODEMP  ';
    strSQL := strSQL + '   AND LOG.CTP_SERIE_ = CADPAG.CTP_SERIE_   ';
    strSQL := strSQL + '   AND LOG.CTP_HISBAI LIKE "REF. PG. RESUMO DE CAIXA DOC.%") AS HORREC, ' ;

    strSQL := strSQL + '  "D" AS CTP_MARDES, ';
    strSQL := strSQL + '  CTP_CTABAI         ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPAG LEFT JOIN CADFOR ON CTP_CODFOR = FOR_CODFOR ';
    strSQL := strSQL + '  LEFT JOIN CADEVE V ON CTP_CODEVE = V.EVE_CODEVE ';
    strSQL := strSQL + '  LEFT JOIN CADPOR R ON CTP_CODPOR = R.POR_CODPOR ';
    strSQL := strSQL + '  LEFT JOIN CADCTA C ON CTP_CODCTA = C.CTA_CODCTA ';
    strSQL := strSQL + '  LEFT JOIN CADEMP E ON CTP_CODEMP = E.EMP_CODEMP ';
    strSQL := strSQL + '  LEFT JOIN CADPOR B ON CTP_PORBAI = B.POR_CODPOR ';
    {Este JOIN estava duplicando os registros em "untRelCtpReimpressaoDocsList"! (Devido a nova opção de Baixa Sintética!)
     ... Em frmQckReimpCtaPagar.pImprimeRecibo foi adicionado informações dos cheques emitidos!
    strSQL := strSQL + '  LEFT JOIN CHQEMI ON CTP_NUMDUP = EMI_NUMDUP AND ';
    strSQL := strSQL + '                      CTP_PARCEL = EMI_PARCEL AND ';
    strSQL := strSQL + '                      CTP_CODEMP = EMI_CODEMP AND ';
    strSQL := strSQL + '                      CTP_DTAPAG = EMI_DTABAI AND ';
    strSQL := strSQL + '                      CTP_CODFOR = EMI_CODFOR AND ';
    strSQL := strSQL + '                      CTP_SERIE_ = EMI_SERIE_ ';
    }
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTP_DTAPAG IS NOT NULL AND ';

    If Not fEmptyStr(edtNumDoc.Text) Then
      strSQL := strSQL + '  CTP_NUMDUP = :NUMDOC '
    Else
    Begin

      strSQL := strSQL + '  CTP_DTAPAG BETWEEN :DTAINI AND :DTAFIN ';

      If Not fEmptyStr(edtNumDoc.Text) Then
        strSQL := strSQL + 'AND CTP_NUMDUP = :NUMDOC ';

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        strSQL := strSQL + 'AND CTP_CODEMP = :CODEMP '
      Else
        strSQL := strSQL + 'AND LOCATE(CTP_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

      If Not fEmptyStr(edtCodFor.Text) Then
        strSQL := strSQL + 'AND CTP_CODFOR = :CODFOR ';

    End;

    If fTemLayoutPersonalizado Then
      strSQL := strSQL + 'GROUP BY CTP_NUMDUP, CTP_PARCEL, CTP_CODEMP, CTP_CODFOR, CTP_SERIE_, CTP_SEQCON';

    With qryGenCtp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(edtNumDoc.Text) Then
        ParamByName('NUMDOC').AsString := edtNumDoc.Text
      Else
      Begin

        ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);

        If Not fEmptyStr(edtNumDoc.Text) Then
          ParamByName('NUMDOC').AsString := edtNumDoc.Text;

        If Not fEmptyStr(edtCodEmpresa.Text) Then
          ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

        If Not fEmptyStr(edtCodFor.Text) Then
          ParamByName('CODFOR').AsString := edtCodFor.Text;

      End;

      Open;
      pSetaClient(qryGenCtp);
      intQtdReg := RecordCount;
      TFloatField(FieldByName('CTP_VALPAG')).DisplayFormat := '#,##0.00';
    End;

    If Not qryGenCtp.IsEmpty Then
    Begin
      Try
        pCriarFormularios(TfrmRelCtpReimpressaoDocsList,frmRelCtpReimpressaoDocsList);
        frmRelCtpReimpressaoDocsList.cdsGenCtp := cdsGenCtp;
        frmRelCtpReimpressaoDocsList.intQtdReg := intQtdReg;

        If intQtdReg = 1 Then
          frmRelCtpReimpressaoDocsList.fImprimirDocumento(True)
        Else
          frmRelCtpReimpressaoDocsList.ShowModal;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[frmRelCtpReimpressaoDocs.btnImprimirClick]');
        End;
      End;

      pFreeAndNil(frmRelCtpReimpressaoDocsList);

    End
    Else
    Begin
      fMensagem('','Não há dados para gerar reimpressão!!!',['&O K']);

      If (Sender = edtNumDoc) Then
      Begin
        edtNumDoc.Clear;
      End;

    End;


  btnImprimir.Enabled := True;
  FreeAndNil(qryGenCtp);
  FreeAndNil(dspGenCtp);
  FreeAndNil(cdsGenCtp);
end;

procedure TfrmRelCtpReimpressaoDoc.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodEmpresa.Text) Then
    edtDesEmpresa.Text := 'TODOS'
  Else
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

  If fEmptyStr(edtDesEmpresa.Text) And (Not fEmptyStr(edtCodEmpresa.Text))  Then
  Begin
    fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
    edtCodEmpresa.Clear;
    pSetFocus(edtCodEmpresa);
  End;

end;

procedure TfrmRelCtpReimpressaoDoc.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fEntraCons(Key) Then
  Begin

    If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp) Then
      Self.SelectNext(ActiveControl, True, True);

  End;

end;

procedure TfrmRelCtpReimpressaoDoc.edtCodForExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodFor.Text) Then
    edtDesFor.Text := 'TODOS'
  Else
    edtDesFor.Text := fRetNomFornecedor(edtCodFor.Text);

  If fEmptyStr(edtDesFor.Text) And (Not fEmptyStr(edtCodFor.Text))  Then
  Begin
    fMensagem('AVISO','Código do fornecedor não encontrado.', ['&O K']);
    edtCodFor.Clear;
    pSetFocus(edtCodFor);
  End;

end;

procedure TfrmRelCtpReimpressaoDoc.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fEntraCons(Key) Then
  Begin

    If fPesqFornecedor(conForSimples, Self, edtCodFor, edtDesFor, Nil, Key, arrFor) Then
      Self.SelectNext(ActiveControl, True, True);

  End;

end;

procedure TfrmRelCtpReimpressaoDoc.edtNumDocChange(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtNumDoc.Text) Then
  Begin
    mskDtaIni.Enabled      := False;
    mskDtaFin.Enabled      := False;
    edtCodFor.Enabled      := False;
    edtCodEmpresa.Enabled  := False;
  End
  Else
  Begin
    mskDtaIni.Enabled      := True;
    mskDtaFin.Enabled      := True;
    edtCodFor.Enabled      := True;
    edtCodEmpresa.Enabled  := True;
  End;
end;

procedure TfrmRelCtpReimpressaoDoc.FormShow(Sender: TObject);
begin
  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  inherited;

  pSetFocus(edtNumDoc);
  edtNumDoc.MaxLength := fTamDocCadRec;
  edtNumDoc.TamCampo  := edtNumDoc.MaxLength;
end;

function TfrmRelCtpReimpressaoDoc.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = edtCodEmpresa) Then
    Begin
      If Not fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('AVISO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;
    End
    {*******************************}
    {* VALIDA DATA INICIAL E FINAL *}
    {****************************JU*}
    Else If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('AVISO!', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End
    Else If (Sender = mskDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('AVISO!', 'O campo Data Final deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
      Begin
        fMensagem('AVISO!','A data inicial deve ser menor que a data final!',['&O K']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
