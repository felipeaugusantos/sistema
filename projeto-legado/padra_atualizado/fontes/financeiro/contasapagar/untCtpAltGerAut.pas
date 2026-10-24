unit untCtpAltGerAut;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Vcl.Mask, MaskEditFocus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView, UniDataSetProvider,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, QColorLabel, Uni, UniClientDataSet,
  Datasnap.DBClient, untPai, cxGridCitel, System.StrUtils;

type
  TfrmCtpAltGerAut = class(TfrmPai)
    pnlCabecalho: TPanel;
    pnlAlteracoes: TPanel;
    gbAtual: TGroupBox;
    gbNovo: TGroupBox;
    dbgDuplicatas: TcxGridCitel;
    dbgDuplicatasView: TcxGridDBTableViewCitel;
    dbgDuplicatasCTP_NUMDUP: TcxGridDBColumn;
    dbgDuplicatasCTP_SERIE_: TcxGridDBColumn;
    dbgDuplicatasCTP_COMPET: TcxGridDBColumn;
    dbgDuplicatasCTP_DTAVEN: TcxGridDBColumn;
    dbgDuplicatasCTP_DTACAD: TcxGridDBColumn;
    dbgDuplicatasCTP_VALDUP: TcxGridDBColumn;
    dbgDuplicatasCTP_DESSUJ: TcxGridDBColumn;
    dbgDuplicatasCTP_JURSUJ: TcxGridDBColumn;
    dbgDuplicatasCTP_MULSUJ: TcxGridDBColumn;
    dbgDuplicatasCTP_NOMPOR: TcxGridDBColumn;
    dbgDuplicatasCTP_CODEVE: TcxGridDBColumn;
    dbgDuplicatasEVE_DESEVE: TcxGridDBColumn;
    dbgDuplicatasLevel1: TcxGridLevel;
    gpbVencimento: TGroupBox;
    lblPeriodicidade: TLabel;
    lbl4: TLabel;
    lbl5: TColorLabel;
    Label1: TLabel;
    edtPeriod: TEditFocus;
    edtDiaFix: TEditFocus;
    edtDtaVen: TcxDateEdit;
    btnConfirmar: TBitBtnLocked;
    dbgDuplicatasNovo: TcxGridCitel;
    dbgDuplicatasNovoView: TcxGridDBTableViewCitel;
    dbgDuplicatasNovoCTP_NUMDUP: TcxGridDBColumn;
    dbgDuplicatasNovoCTP_COMPET: TcxGridDBColumn;
    dbgDuplicatasNovoCTP_DTAVEN: TcxGridDBColumn;
    dbgDuplicatasNovoCTP_DTACAD: TcxGridDBColumn;
    dbgDuplicatasNovoCTP_VALDUP: TcxGridDBColumn;
    dbgDuplicatasNovoCTP_DESSUJ: TcxGridDBColumn;
    dbgDuplicatasNovoCTP_JURSUJ: TcxGridDBColumn;
    dbgDuplicatasNovoCTP_MULSUJ: TcxGridDBColumn;
    dbgDuplicatasNovoCTP_CODEVE: TcxGridDBColumn;
    dbgDuplicatasNovoEVE_DESEVE: TcxGridDBColumn;
    dbgDuplicatasNovoLevel1: TcxGridLevel;
    dbgDuplicatasTOTDUP: TcxGridDBColumn;
    dbgDuplicatasNovoTOTDUP: TcxGridDBColumn;
    gbOpcao: TGroupBox;
    ColorLabel1: TColorLabel;
    ColorLabel2: TColorLabel;
    ColorLabel3: TColorLabel;
    Label2: TLabel;
    edtOpcao: TEditFocus;
    btnConfirma: TBitBtnLocked;
    dbgDuplicatasCTP_CODCTA: TcxGridDBColumn;
    dbgDuplicatasCTA_DESCTA: TcxGridDBColumn;
    dbgDuplicatasNovoCTP_CODCTA: TcxGridDBColumn;
    dbgDuplicatasNovoCTA_DESCTA: TcxGridDBColumn;
    dbgDuplicatasCTP_PREVIS: TcxGridDBColumn;
    dbgDuplicatasCTP_VEIONF: TcxGridDBColumn;
    dbgDuplicatasCTP_USOCON: TcxGridDBColumn;
    dbgDuplicatasCTP_PAGANT: TcxGridDBColumn;
    dbgDuplicatasNovoCTP_PREVIS: TcxGridDBColumn;
    dbgDuplicatasNovoCTP_VEIONF: TcxGridDBColumn;
    dbgDuplicatasNovoCTP_USOCON: TcxGridDBColumn;
    dbgDuplicatasNovoCTP_PAGANT: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtDiaFixExit(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtOpcaoChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    procedure pAtualizaTemporaria;
    procedure pAtualizaTemporariaNovo;

    { Private declarations }
  protected
      function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    fltValDup,
    fltDesSuj,
    fltJurSuj,
    fltMulSuj : Double;
    strNumDup,
    strParcel,
    strSerie,
    strCompet,
    strCodEmp,
    strCodFor,
    strNomFor,
    strCodEve,
    strDesEve,
    strCodPor,
    strNomPor,
    strCodCta,
    strDesCta,
    strPrevis,
    strVeioNF,
    strUsoCon,
    strPagAnt,

    strDtaVen,
    strDtaCad : string;

    blnAlt_strCompet,
    blnAlt_strDtaVen,
    blnAlt_strDtaCad,
    blnAlt_strValDup,
    blnAlt_strDesSuj,
    blnAlt_strJurSuj,
    blnAlt_strMulSuj,
    blnAlt_strCodPor,
    blnAlt_strCodEve,
    blnAlt_strCodCta,
    blnAlt_strPrevis,
    blnAlt_strVeioNF,
    blnAlt_strPagant,
    blnAlt_strUsoCon     : Boolean;

    cdsCtaPag: TUniClientDataSet;
    dtsCtaPag: TDataSource;

    blnConfirma : Boolean;
  end;

var
  frmCtpAltGerAut: TfrmCtpAltGerAut;

implementation

{$R *.dfm}

uses untFuncoesSimples, untGravando, untTypesSistema, untManGerAutCtaPagar;

procedure TfrmCtpAltGerAut.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If not fValidaCampos(edtOpcao, True) Then
    exit;

  If not pnlAlteracoes.Visible Then
    exit;

  blnConfirma := True;
  Close;
end;

procedure TfrmCtpAltGerAut.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  If  fVerificaCampos Then
  Begin
    TfrmGravando.fExecutarModal(pAtualizaTemporaria, 'Aguarde... Carregando Títulos.', '');
    TfrmGravando.fExecutarModal(pAtualizaTemporariaNovo, 'Aguarde... Carregando Alterações dos Títulos.','');
    pSetFocus(dbgDuplicatasNovo);
  End;
end;


procedure TfrmCtpAltGerAut.edtDiaFixExit(Sender: TObject);
begin
  inherited;
  lblPeriodicidade.Visible := (edtDiaFix.Text <> 'S');
  edtPeriod.Visible        := (edtDiaFix.Text <> 'S');
end;

procedure TfrmCtpAltGerAut.edtOpcaoChange(Sender: TObject);
begin
  inherited;
  gpbVencimento.Visible := (TEditFocus(Sender).Text <> '1');
end;

procedure TfrmCtpAltGerAut.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  pnlAlteracoes.Visible := true;

  cdsCtaPag := TUniClientDataSet.Create(Self);
  dtsCtaPag := fCriaDataSource(cdsCtaPag);
  dbgDuplicatasView.DataController.DataSource := dtsCtaPag;
end;

procedure TfrmCtpAltGerAut.FormDestroy(Sender: TObject);
begin
  (dbgDuplicatasNovoView.DataController.DataSource.DataSet as TUniClientDataSet).EmptyDataSet;
  cdsCtaPag.Close;
  pFreeAndNil(dtsCtaPag);
  pFreeAndNil(cdsCtaPag);
  inherited;
end;

procedure TfrmCtpAltGerAut.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F10) Then
    btnConfirma.Click
  else If (Key = VK_Escape) Then
  Begin
    (dbgDuplicatasNovoView.DataController.DataSource.DataSet as TUniClientDataSet).EmptyDataSet;
    cdsCtaPag.Close;
  End;
end;

procedure TfrmCtpAltGerAut.pAtualizaTemporaria;
var
  qryCtaPag: TUniQuery;
  dspCtaPag: TUniDataSetProvider;
begin
  cdsCtaPag.Filtered := False;
  cdsCtaPag.Close;
  qryCtaPag := fCriaQuery(Self);
  dspCtaPag := TUniDataSetProvider.Create(Self);
  try
    dspCtaPag.DataSet := qryCtaPag;
    cdsCtaPag.SetProvider(dspCtaPag);

    Try
      qryCtaPag.SQL.Add('SELECT ');
      qryCtaPag.SQL.Add('  P.AUTOINCREM, ');
      qryCtaPag.SQL.Add('  P.CTP_DTAVEN, ');
      qryCtaPag.SQL.Add('  P.CTP_DTACAD, ');
      qryCtaPag.SQL.Add('  P.CTP_VALDUP, ');
      qryCtaPag.SQL.Add('  IFNULL(P.CTP_DESSUJ, 0) AS CTP_DESSUJ, ');
      qryCtaPag.SQL.Add('  IFNULL(P.CTP_JURSUJ, 0) AS CTP_JURSUJ, ');
      qryCtaPag.SQL.Add('  IFNULL(P.CTP_MULSUJ, 0) AS CTP_MULSUJ, ');
      qryCtaPag.SQL.Add('  (P.CTP_VALDUP + IFNULL(P.CTP_JURSUJ,0) + IFNULL(P.CTP_MULSUJ,0) + IFNULL(P.CTP_VENDOR,0)) -IFNULL(P.CTP_DESSUJ,0) AS TOTDUP, ');
      qryCtaPag.SQL.Add('  P.CTP_CODPOR, ');
      qryCtaPag.SQL.Add('  CONCAT(P.CTP_CODPOR ,"-", R.POR_NOMPOR) AS CTP_NOMPOR, ');
      qryCtaPag.SQL.Add('  P.CTP_CODEVE, ');
      qryCtaPag.SQL.Add('  V.EVE_DESEVE, ');
      qryCtaPag.SQL.Add('  P.CTP_CODCTA, ');
      qryCtaPag.SQL.Add('  C.CTA_DESCTA, ');
      qryCtaPag.SQL.Add('  P.CTP_COMPET, ');
      qryCtaPag.SQL.Add('  CONCAT(P.CTP_NUMDUP, P.CTP_PARCEL) AS CTP_NUMDUP, ');
      qryCtaPag.SQL.Add('  P.CTP_NUMDUP AS NRODUP, ');
      qryCtaPag.SQL.Add('  P.CTP_PARCEL, ');
      qryCtaPag.SQL.Add('  P.CTP_SEQBAI, ');
      qryCtaPag.SQL.Add('  P.CTP_CODEMP, ');
      qryCtaPag.SQL.Add('  P.CTP_CODFOR, ');
      qryCtaPag.SQL.Add('  P.CTP_SERIE_, ');
      qryCtaPag.SQL.Add('  IF(P.CTP_PREVIS = "S", "SIM", "NÃO") AS CTP_PREVIS, ');
      qryCtaPag.SQL.Add('  IF(P.CTP_VEIONF = "S", "SIM", "NÃO") AS CTP_VEIONF, ');
      qryCtaPag.SQL.Add('  IF(P.CTP_PAGANT = "S", "SIM", "NÃO") AS CTP_PAGANT, ');
      qryCtaPag.SQL.Add('  IF(P.CTP_USOCON = "S", "SIM", "NÃO") AS CTP_USOCON ');
      qryCtaPag.SQL.Add('FROM ');
      qryCtaPag.SQL.Add('  CADPAG P ');
      qryCtaPag.SQL.Add('  JOIN CADCTA C ON P.CTP_CODCTA = C.CTA_CODCTA ');
      qryCtaPag.SQL.Add('  LEFT JOIN CADEVE V ON P.CTP_CODEVE = V.EVE_CODEVE ');
      qryCtaPag.SQL.Add('  LEFT JOIN CADPOR R ON P.CTP_CODPOR = R.POR_CODPOR ');
      qryCtaPag.SQL.Add('WHERE P.CTP_NUMDUP = :CTP_NUMDUP ');
      if edtOpcao.Text = '1' then
      begin
        qryCtaPag.SQL.Add('  AND P.CTP_PARCEL = :CTP_PARCEL ');
        qryCtaPag.ParamByName('CTP_PARCEL').AsString := strParcel;

        If not fEmptyStr(fTiraCaracEspeciais(strSerie)) then
        begin
          qryCtaPag.SQL.Add('  AND P.CTP_SERIE_ = :CTP_SERIE_ ');
          qryCtaPag.ParamByName('CTP_SERIE_').AsString := strSerie;
        end;
      end
      else if edtOpcao.Text = '2' then
      begin
        qryCtaPag.SQL.Add('  AND ASCII(P.CTP_PARCEL) >= ASCII(:CTP_PARCEL) ');

        qryCtaPag.ParamByName('CTP_PARCEL').AsString := strParcel;
        If not fEmptyStr(fTiraCaracEspeciais(strSerie)) then
        begin
          qryCtaPag.SQL.Add('  AND P.CTP_SERIE_ >= :CTP_SERIE_ ');
          qryCtaPag.ParamByName('CTP_SERIE_').AsString := strSerie;
        end;
      end;

      qryCtaPag.SQL.Add('  AND P.CTP_CODFOR = :CTP_CODFOR ');
      qryCtaPag.SQL.Add('  AND P.CTP_CODEMP = :CTP_CODEMP ');

      qryCtaPag.SQL.Add('  AND P.CTP_DTAPAG IS NULL ');
      qryCtaPag.SQL.Add('  AND P.CTP_SEQBAI = 0 ');
      qryCtaPag.SQL.Add('  AND (SELECT COUNT(1) QTD ');
      qryCtaPag.SQL.Add('         FROM CADPAG P1 ');
      qryCtaPag.SQL.Add('        WHERE P1.CTP_NUMDUP = P.CTP_NUMDUP ');
      qryCtaPag.SQL.Add('          AND P1.CTP_PARCEL = P.CTP_PARCEL ');
      qryCtaPag.SQL.Add('          AND P1.CTP_CODFOR = P.CTP_CODFOR ');
      qryCtaPag.SQL.Add('          AND P1.CTP_SERIE_ = P.CTP_SERIE_ ');
      qryCtaPag.SQL.Add('          AND P1.CTP_CODEMP = P.CTP_CODEMP) = 1 ');

      qryCtaPag.SQL.Add('  ORDER BY P.CTP_DTAVEN ');

      qryCtaPag.ParamByName('CTP_NUMDUP').AsString := strNumDup;
      qryCtaPag.ParamByName('CTP_CODFOR').AsString := strCodFor;
      qryCtaPag.ParamByName('CTP_CODEMP').AsString := strCodEmp;
      qryCtaPag.Open;

      Application.ProcessMessages;

      If Not qryCtaPag.IsEmpty Then
      Begin
        pSetaClient(qryCtaPag);
        cdsCtaPag.Open;
        With cdsCtaPag Do
        Begin
          (FieldByName('CTP_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('CTP_DESSUJ') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('CTP_JURSUJ') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('CTP_MULSUJ') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('TOTDUP') As TFloatField).DisplayFormat := '#,##0.00';
          //IndexFieldNames := 'CTP_NUMDUP';
          First;
        End;
      End
      Else
        fMensagem('ATENÇÃO!', 'Nenhuma duplicata foi encontrada!', ['&Ok']);

      qryCtaPag.Close;
    Except
      On E: Exception Do
        Raise Exception.Create('Ocorreu um erro ao atualizar as duplicatas.' + #13 +
                               'Erro gerado: ' + E.Message);
    End;
  finally
    Application.ProcessMessages;
    cdsCtaPag.SetProvider(nil);
    FreeAndNil(dspCtaPag);
    FreeAndNil(qryCtaPag);
  end;
end;

procedure TfrmCtpAltGerAut.pAtualizaTemporariaNovo;
var
  dtaParcela : TDateTime;
  dtaDtaBas  : TDateTime;
  intIndice  : Integer;
  dtaCompetDia  : TDateTime;
  dtaCompetAlt  : TDateTime;
  intMes : Integer;
  prcScroll  : TprcScroll;
  bnlEncontrou : Boolean;
begin
  if cdsCtaPag.IsEmpty then
    Abort;

  pDisableControls(cdsCtaPag, prcScroll);
  cdsCtaPag.AggregatesActive := False;
  try
    Try
      (dbgDuplicatasNovoView.DataController.DataSource.DataSet as TUniClientDataSet).EmptyDataSet;
      dtaParcela := edtDtaVen.Date;

      dtaDtaBas := dtaParcela;
      intIndice := 1;
      bnlEncontrou := True;

      dtaCompetDia := StrToDate('01/' + strCompet);
      dtaCompetAlt := dtaCompetDia;
      intMes := 1;

      cdsCtaPag.First;
      while not cdsCtaPag.Eof do
      Begin
        with (dbgDuplicatasNovoView.DataController.DataSource.DataSet as TUniClientDataSet) do
        begin
          Append;

          FieldByName('AUTOINCREM').AsString   := cdsCtaPag.FieldByName('AUTOINCREM').AsString;
          FieldByName('NRODUP').AsString       := cdsCtaPag.FieldByName('NRODUP').AsString;
          FieldByName('CTP_NUMDUP').AsString   := cdsCtaPag.FieldByName('CTP_NUMDUP').AsString;
          FieldByName('CTP_PARCEL').AsString   := cdsCtaPag.FieldByName('CTP_PARCEL').AsString;
          FieldByName('CTP_SEQBAI').AsString   := cdsCtaPag.FieldByName('CTP_SEQBAI').AsString;
          FieldByName('CTP_SERIE_').AsString   := cdsCtaPag.FieldByName('CTP_SERIE_').AsString;
          FieldByName('CTP_CODEMP').AsString   := cdsCtaPag.FieldByName('CTP_CODEMP').AsString;
          FieldByName('CTP_CODFOR').AsString   := cdsCtaPag.FieldByName('CTP_CODFOR').AsString;

          If edtopcao.Text = '3' Then
          Begin
             If cdsCtaPag.FieldByName('CTP_DTAVEN').AsDateTime >= strToDateTime(strDtaVen) Then
             Begin
                If bnlEncontrou Then
                Begin
                   dtaParcela   := edtDtaVen.Date;
                   dtaDtaBas    := dtaParcela;
                   intIndice    := 1;
                   bnlEncontrou := False;
                End;
                FieldByName('CTP_DTAVEN').AsDateTime := dtaParcela;
             End
             Else
                FieldByName('CTP_DTAVEN').AsDateTime := cdsCtaPag.FieldByName('CTP_DTAVEN').AsDateTime;
          End
          Else
             FieldByName('CTP_DTAVEN').AsDateTime := dtaParcela;

          FieldByName('CTP_COMPET').AsString   := IIF( blnAlt_strCompet, FormatDateTime('mm/yyyy', dtaCompetDia), cdsCtaPag.FieldByName('CTP_COMPET').AsString );
          FieldByName('CTP_VALDUP').AsFloat    := IIF( blnAlt_strValDup, fltValDup, cdsCtaPag.FieldByName('CTP_VALDUP').AsFloat  );
          FieldByName('CTP_VALORI').AsFloat    := FieldByName('CTP_VALDUP').AsFloat;
          FieldByName('CTP_DESSUJ').AsFloat    := IIF( blnAlt_strDesSuj, fltDesSuj, cdsCtaPag.FieldByName('CTP_DESSUJ').AsFloat );
          FieldByName('CTP_JURSUJ').AsFloat    := IIF( blnAlt_strJurSuj, fltJurSuj, cdsCtaPag.FieldByName('CTP_JURSUJ').AsFloat );
          FieldByName('CTP_MULSUJ').AsFloat    := IIF( blnAlt_strMulSuj, fltMulSuj, cdsCtaPag.FieldByName('CTP_MULSUJ').AsFloat );
          FieldByName('CTP_CODEVE').AsString   := IIF( blnAlt_strCodEve, strCodEve, cdsCtaPag.FieldByName('CTP_CODEVE').AsString);
          FieldByName('EVE_DESEVE').AsString   := IIF( blnAlt_strCodEve, strDesEve, cdsCtaPag.FieldByName('EVE_DESEVE').AsString);
          FieldByName('CTP_DTACAD').AsDateTime := IIF( blnAlt_strDtaCad, StrToDate(strDtaCad), cdsCtaPag.FieldByName('CTP_DTACAD').AsDateTime);
          FieldByName('CTP_CODPOR').AsString   := IIF( blnAlt_strCodPor, strCodPor, cdsCtaPag.FieldByName('CTP_CODPOR').AsString);
          FieldByName('CTP_NOMPOR').AsString   := IIF( blnAlt_strCodPor, Concat(strCodPor, '-', strNomPor), cdsCtaPag.FieldByName('CTP_NOMPOR').AsString);
          FieldByName('CTP_CODCTA').AsString   := IIF( blnAlt_strCodCta, strCodCta, cdsCtaPag.FieldByName('CTP_CODCTA').AsString);
          FieldByName('CTA_DESCTA').AsString   := IIF( blnAlt_strCodCta, strDesCta, strDesCta);
          FieldByName('CTP_PREVIS').AsString   := IIF( blnAlt_strPrevis, IfThen(strPrevis = 'S','SIM','NÃO'), cdsCtaPag.FieldByName('CTP_PREVIS').AsString) ;
          FieldByName('CTP_VEIONF').AsString   := IIF( blnAlt_strVeioNF, IfThen(strVeioNF = 'S','SIM','NÃO'), cdsCtaPag.FieldByName('CTP_VEIONF').AsString);
          FieldByName('CTP_USOCON').AsString   := IIF( blnAlt_strUsoCon, IfThen(strUsoCon = 'S','SIM','NÃO'), cdsCtaPag.FieldByName('CTP_USOCON').AsString );
          FieldByName('CTP_PAGANT').AsString   := IIF( blnAlt_strPagant, IfThen(strPagant = 'S','SIM','NÃO'), cdsCtaPag.FieldByName('CTP_PAGANT').AsString);

          //FieldByName('TOTDUP').AsFloat        := fltValDup + fltValJur - fltValDes;
          FieldByName('TOTDUP').AsFloat        := FieldByName('CTP_VALDUP').AsFloat +
                                                  FieldByName('CTP_JURSUJ').AsFloat +
                                                  FieldByName('CTP_MULSUJ').AsFloat -
                                                  FieldByName('CTP_DESSUJ').AsFloat;

          Post;

          if edtOpcao.Text <> '1'  then
          begin
            If (edtDiaFix.Text = 'S') Then
            Begin
              dtaParcela := IncMonth(dtaDtaBas, intIndice);
              Inc(intIndice);
            End
            Else
              dtaParcela := dtaParcela + StrToInt(edtPeriod.Text);

            //data competência
            dtaCompetDia := incMonth(dtaCompetAlt, intMes);
            Inc(intMes);

          end;
        end;

        Application.ProcessMessages;
        cdsCtaPag.Next;
      End;

    Except
      On E: Exception Do
        Raise Exception.Create('Ocorreu um erro ao alterar as duplicatas.' + #13 +
                               'Erro gerado: ' + E.Message);
    End;
  finally
    cdsCtaPag.AggregatesActive := True;
    pEnableControls(cdsCtaPag, prcScroll);
  end;
end;

function TfrmCtpAltGerAut.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If Sender = edtOpcao Then
    Begin
      If fEmptyStr(edtOpcao.Text) Then
      Begin
        fMensagem('ATENÇÃO','A opção de alteração de lançamento deve ser preenchido!',['&O K']);
        Result := False;
      End
      else If (Pos(edtOpcao.Text, '123') <= 0) Then
      Begin
        fMensagem('ATENÇÃO','A opção de alteração de lançamento deve ser 1, 2 ou 3!',['&O K']);
        Result := False;
      End;
    End
    Else If (Sender =  edtDiaFix) and (edtOpcao.Text <> '1') Then
    Begin

      If (Pos(edtDiaFix.Text, 'SN') <= 0) Then
      Begin
        Result := False;
      End
      Else If (edtDiaFix.Text = 'S') Then
      Begin
        lblPeriodicidade.Visible := False;
        edtPeriod.Visible := False;
      End
      Else
      Begin
        lblPeriodicidade.Visible := True;
        edtPeriod.Visible := True;
      End;
    End
    Else If (Sender = edtPeriod) And (edtPeriod.Visible) and (edtOpcao.Text <> '1') Then
    Begin

      If fEmptyStr(edtPeriod.Text) Then
      Begin
        fMensagem('ATENÇÃO','A Periodicidade Vencimento deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else If (edtPeriod.Text <= '0') Then
      Begin
        fMensagem('ATENÇÃO','A Periodicidade Vencimento deve ser maior que Zero!',['&O K']);
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

end.
