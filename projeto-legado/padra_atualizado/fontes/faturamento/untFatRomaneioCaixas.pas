unit untFatRomaneioCaixas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, StrUtils,
  UniClientDataSet, untTypesSistema, Uni, cxCurrencyEdit, Datasnap.DBClient,
  cxTextEdit, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmFatRomaneioCaixas = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    Label13: TLabel;
    edtCodTra: TEditFocus;
    edtDesTra: TEditFocus;
    blnSituacao: TPanel;
    Label1: TLabel;
    edtCodBar: TEditFocus;
    Label2: TLabel;
    edtCodBarUltimo: TEditFocus;
    cxGridDBDocumentos: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxGrid: TcxGrid;
    cdsDocumentos: TUniClientDataSet;
    cdsDocumentosAUTOINCREM: TStringField;
    cdsDocumentosDOCUMENTO: TStringField;
    cdsDocumentosNUMDOC: TStringField;
    cdsDocumentosESPDOC: TStringField;
    cdsDocumentosCODEMP: TStringField;
    cdsDocumentosCODBAR: TStringField;
    cdsDocumentosDTAENT: TDateField;
    cdsDocumentosCODCLI: TStringField;
    cdsDocumentosNOMCLI: TStringField;
    cdsDocumentosCODVEN: TStringField;
    cdsDocumentosVLRCON: TFloatField;
    cxGridDBDocumentosDTAENT: TcxGridDBColumn;
    cxGridDBDocumentosCODCLI: TcxGridDBColumn;
    cxGridDBDocumentosNOMCLI: TcxGridDBColumn;
    cxGridDBDocumentosCODVEN: TcxGridDBColumn;
    cxGridDBDocumentosVLRCON: TcxGridDBColumn;
    cxGridDBDocumentosVOLUME: TcxGridDBColumn;
    cxGridDBDocumentosDOCUMENTO: TcxGridDBColumn;
    cdsDocumentosTABELA: TStringField;
    cdsDocumentosCODTRA: TStringField;
    btnDeletaDocumento: TBitBtnLocked;
    cdsDocumentosOK: TStringField;
    cxGridDBDocumentosOK: TcxGridDBColumn;
    cdsDocumentosVOLUME: TStringField;
    cdsDocumentosQTDVOL: TIntegerField;
    cdsDocumentosTOTVOL: TIntegerField;
    cdsCodBar: TUniClientDataSet;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    cdsCodBarSEQVOL: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure edtCodTraExit(Sender: TObject);
    procedure edtCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnDeletaDocumentoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridDBDocumentosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    strOpcRom: String;
    arrTransp: TConsultasArray;
    dtsDocumentos: TDataSource;
    function fRetornaEspeciePeloCodigo(strCodigo: String): String;
    function fBuscaDocumento(strCodBar: String):Boolean;
    procedure pSituacao(strCodBar: String; blnOK: Boolean);
    function fExisteVolumesFaltantes: Boolean;
    procedure pAtualizaTela;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    strDocumentos:  String;
    { Public declarations }
  end;

var
  frmFatRomaneioCaixas: TfrmFatRomaneioCaixas;

implementation

{$R *.dfm}

uses untFuncoesSimples, untFuncoesConsulta, untConsultas, untMemo;

function TfrmFatRomaneioCaixas.fRetornaEspeciePeloCodigo(strCodigo: String): String;
begin
  If strCodigo = '01'      Then Result := 'NF'
  Else If strCodigo = '02' Then Result := 'IF'
  Else If strCodigo = '03' Then Result := 'MI'
  Else If strCodigo = '04' Then Result := 'FF'
  Else If strCodigo = '05' Then Result := 'TE'
  Else If strCodigo = '06' Then Result := 'BR'
  Else If strCodigo = '07' Then Result := 'TR'
  Else If strCodigo = '08' Then Result := 'DV'
  Else If strCodigo = '09' Then Result := 'PD'
  Else If strCodigo = '10' Then Result := 'D1';
end;

procedure TfrmFatRomaneioCaixas.pSituacao(strCodBar: String; blnOK:Boolean);
Begin
  edtCodBarUltimo.Text := strCodBar;
  If blnOK Then
    blnSituacao.Color := clGreen
  Else
    blnSituacao.Color := clRed;
End;

procedure TfrmFatRomaneioCaixas.pAtualizaTela;
begin
  if cdsDocumentos.isEmpty then
  Begin
    edtCodTra.Enabled     := True;
    edtCodTra.NormalColor := clWindow;
  End
  Else
  Begin
    edtCodTra.Enabled     := False;
    edtCodTra.NormalColor := $00FFDFB8;
  End;
end;

function TfrmFatRomaneioCaixas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;

begin
  Result := True;

  If (Sender = edtCodBar) Then
  Begin
    If fEmptyStr(edtDesTra.Text) Then
    Begin
      pMensagemOk('Informe a transportadora!');
      pSetFocus(edtCodTra);
      Exit;
    End;

    If fEmptyStr(edtCodBar.Text) Or
       ((Pos('CXSEQ', edtCodBar.Text) > 0) And (Length(edtCodBar.text) < 13)) Or
       ((Pos('CXSEQ', edtCodBar.Text) = 0) And (Length(edtCodBar.text) < 23)) Then
    Begin
      pSituacao(edtCodBar.Text, False);
      pMensagemOk('Código de barras inválido!');
      edtCodBar.Clear;
      Result := False;
      Exit;
    End
    Else
    Begin
      If fBuscaDocumento(edtCodBar.Text) Then
      Begin
        pSituacao(edtCodBar.Text, True);
        edtCodBar.Clear;
        Result := False;
      End
      Else
      Begin
        pSituacao(edtCodBar.Text, False);
        edtCodBar.Clear;
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

  pAtualizaTela;

end;

function TfrmFatRomaneioCaixas.fExisteVolumesFaltantes: Boolean;
var stlMsg: TStringList;
Begin
  Result := False;
  stlMsg := TStringList.Create;

  Try

    stlMsg.Add('|-----------------------------------------------------------------------------------------------------------|');
    stlMsg.Add('|                                       VOLUMES QUE NAO FORAM BIPADOS                                       |');
    stlMsg.Add('|-----------------------------------------------------------------------------------------------------------|');
    stlMsg.Add('| DT.VENDA   | DOCUMENTO           | CLIENTE                                 | VEN | VR.DOCUMENTO | VOLUMES |');
    stlMsg.Add('|-----------------------------------------------------------------------------------------------------------|');

    With cdsDocumentos Do
    Begin
      DisableControls;
      First;
      While not eof Do
      Begin
        If (FieldByName('QTDVOL').AsInteger <> FieldByName('TOTVOL').AsInteger) Then
        Begin
          Result := True;
          stlMsg.Add('| ' + fPadL(FieldByName('DTAENT').AsString, 10, ' ') +' | '+
                            fPadR(FieldByName('DOCUMENTO').AsString, 19, ' ') + ' | '+
                            fPadR(FieldByName('CODCLI').AsString +'-'+FieldByName('NOMCLI').AsString, 39, ' ') + ' | '+
                            fPadL(FieldByName('CODVEN').AsString, 3, ' ') + ' | '+
                            fPadL(FormatFloat('#,##0.00',FieldByName('VLRCON').AsFloat), 12, ' ') + ' | '+
                            fPadL( IntToStr(FieldByName('TOTVOL').AsInteger - FieldByName('QTDVOL').AsInteger), 7, ' ')  + ' |') ;
        End;

        Next;
      End;
      EnableControls;
    End;
    stlMsg.Add('|-----------------------------------------------------------------------------------------------------------|');

    If Result Then
      TfrmMemo.pShowMessage(stlMsg, 8);

  Finally
    stlMsg.Free;
  End;
End;

procedure TfrmFatRomaneioCaixas.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If not fExisteVolumesFaltantes Then
  Begin
    strDocumentos  := '';
    With cdsDocumentos do
    Begin
      DisableControls;
      First;
      While not eof do
      Begin
        strDocumentos := strDocumentos + FieldByName('AUTOINCREM').AsString + '_' ;

        Next;
      End;
      EnableControls;
    End;
    ModalResult := mrOK;
  End;
end;

procedure TfrmFatRomaneioCaixas.btnDeletaDocumentoClick(Sender: TObject);
begin
  inherited;
  If cdsDocumentos.isEmpty Then
    Exit;

  If fMensagem('', 'Confirma exclusão do documento selecionado? ', ['&Sim', '&Não']) = 1 Then
  begin
    cdsCodBar.First;
    While not cdsCodBar.eof Do
    Begin
      If ( (cdsCodBar.FieldByName('NUMDOC').AsString = cdsDocumentos.FieldByName('NUMDOC').AsString) And
           (cdsCodBar.FieldByName('ESPDOC').AsString = cdsDocumentos.FieldByName('ESPDOC').AsString) And
           (cdsCodBar.FieldByName('CODEMP').AsString = cdsDocumentos.FieldByName('CODEMP').AsString) ) Then
        cdsCodBar.Delete
      Else
        cdsCodBar.Next;
    End;
    cdsDocumentos.Delete;
    pAtualizaTela;
    pSetFocus(edtCodBar);
  end;
end;

procedure TfrmFatRomaneioCaixas.cxGridDBDocumentosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridDBDocumentosOK.Index]) = 'S' Then
      ACanvas.Brush.Color := clGreen;
end;

procedure TfrmFatRomaneioCaixas.edtCodTraExit(Sender: TObject);
begin
  inherited;
  if not fEmptyStr(edtCodTra.Text) then
    pEdtCodSelectExit(edtCodTra,edtDesTra,arrTransp,fRetNomTransportadora,nil,'da Transportadora')
  Else
    edtDesTra.Clear;
end;

procedure TfrmFatRomaneioCaixas.edtCodTraKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqTransportadora(conTraSimples, Self, edtCodTra, edtDesTra, nil, Key, arrTransp) Then
  Begin
    If fValidaCampos(edtCodTra, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatRomaneioCaixas.FormCreate(Sender: TObject);
begin
  inherited;
  strDocumentos  := '';
  cdsCodBar.CreateDataSet;
  cdsDocumentos.CreateDataSet;
  dtsDocumentos := fCriaDataSource(cdsDocumentos);
  cxGridDBDocumentos.DataController.DataSource := dtsDocumentos;
  strOpcRom := fCfgSis('OPCROM');

  If fCfgSis('TIPBAR', varString) = '2' Then
   edtCodbar.MaxLength := 43;
end;

procedure TfrmFatRomaneioCaixas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
     VK_F6: btnDeletaDocumento.Click;
    VK_F10: btnConfirma.Click;
  End;
end;

function TfrmFatRomaneioCaixas.fBuscaDocumento(strCodBar: String):Boolean;
Var
  qryDocumentos: TUniQuery;
  strSQL,
  strMovGer,
  strNotGer: String;
  intSeqVol,
  intTotVol: Integer;
  blnEtqCaixa: Boolean;

  function fTravaRomaneio(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  var strRomaneio: String;
  Begin
    strRomaneio := fCampoTabela('GER_NUMROM', 'ROMGERX', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'], [strNumDoc, strEspDoc, strCodEmp]);

    if not fEmptyStr(strRomaneio) Then
    Begin
      fMensagem('ATENÇÃO!','Este documento de venda já está no romaneio '+ strRomaneio  + #13+
                           'Não será permitido neste romaneio.', ['&Ok']);
      Result := False;
    End
    Else
      Result := True;
  End;

  function fTravaVolume(strCodBar: String): Boolean;
  Begin
    If (not blnEtqCaixa) And (intSeqVol = 0) Then
    Begin
      fMensagem('ATENÇÃO!','Este código de barras esta com o volume zerado.', ['&Ok']);
      Result := False;
    End
    Else
      Result := True;
  End;

  function fTravaCodBar(strCodBar: String): Boolean;
  Begin
    if cdsCodBar.locate('CODBAR',strCodBar,[loPartialKey]) Then
    Begin
      fMensagem('ATENÇÃO!','Este código de barras já foi bipado neste romaneio.', ['&Ok']);
      Result := False;
    End
    Else
      Result := True;
  End;

  function fTravaEspDoc(strCodBar: String): Boolean;
  var strEspDoc: String;
  Begin
    If blnEtqCaixa Then
      strEspDoc := qryDocumentos.FieldByName('GER_ESPDOC').AsString
    Else
      strEspDoc := fRetornaEspeciePeloCodigo(Copy(strCodBar, 13, 2));

    if (strOpcRom = '3') And (strEspDoc <> 'NF') Then
    Begin
      fMensagem('ATENÇÃO!','Não é permitido espécie ['+strEspDoc+'] usando romaneio [3]', ['&Ok']);
      Result := False;
    End
    Else
      Result := True;
  End;

  function fTravaTransportadora(strCodTra: String): Boolean;
  Begin
    If edtCodTra.Text <> strCodTra then
    Begin
      fMensagem('ATENÇÃO!', 'Este documento de venda tem outra transportadora informada.'+#13+
                 qryDocumentos.FieldByName('GER_CODTRA').AsString + '-' + qryDocumentos.FieldByName('TRA_NOMTRA').AsString+#13+
                'Não será permitido neste romaneio.', ['&Ok']);
      Result := False;
    End
    Else
      Result := True;
  End;

  procedure pAddCodBar(strCodBar, strNumDoc, strEspDoc, strCodEmp: String; intSeqVol:Integer);
  begin
    cdsCodBar.Insert;
    cdsCodBar.FieldByName('CODBAR').AsString  := strCodBar;
    cdsCodBar.FieldByName('NUMDOC').AsString  := strNumDoc;
    cdsCodBar.FieldByName('ESPDOC').AsString  := strEspDoc;
    cdsCodBar.FieldByName('CODEMP').AsString  := strCodEmp;
    cdsCodBar.FieldByName('SEQVOL').AsInteger := intSeqVol;
    cdsCodBar.Post;
  end;

  procedure pDocumentoOK;
  Begin
    If cdsDocumentos.FieldByName('QTDVOL').AsInteger = cdsDocumentos.FieldByName('TOTVOL').AsInteger Then
    Begin
      cdsDocumentos.Edit;
      cdsDocumentos.FieldByName('OK').AsString := 'S';
      cdsDocumentos.Post;
    End;
  End;

begin
  inherited;

  blnEtqCaixa := (Pos('CXSEQ', strCodBar) > 0);

  If not blnEtqCaixa Then
  Begin
    intSeqVol := StrToIntDef(Copy(strCodBar, 18, 3), 0);
    intTotVol := StrToIntDef(Copy(strCodBar, 21, 3), 0)
  End
  Else
  Begin
    intSeqVol := 0;
    intTotVol := 0;
  End;

  Try
    qryDocumentos := fCriaQuery(Self);

    strMovGer := '';
    strMovGer := strMovGer + 'SELECT DISTINCT                                     ';
    strMovGer := strMovGer + ' "MOVGER" AS TABELA,                                ';
    strMovGer := strMovGer + ' A.AUTOINCREM,                                      ';
    strMovGer := strMovGer + ' GER_NUMDOC,                                        ';
    strMovGer := strMovGer + ' GER_ESPDOC,                                        ';
    strMovGer := strMovGer + ' GER_CODEMP,                                        ';
    strMovGer := strMovGer + ' GER_DTAENT,                                        ';
    strMovGer := strMovGer + ' CLI_CODCLI,                                        ';
    strMovGer := strMovGer + ' CLI_NOMCLI,                                        ';
    strMovGer := strMovGer + ' GER_CODVEN,                                        ';
    strMovGer := strMovGer + ' GER_VLRCON,                                        ';
    strMovGer := strMovGer + ' GER_VOLUME,                                        ';
    strMovGer := strMovGer + ' GER_CODTRA,                                        ';
    strMovGer := strMovGer + ' TRA_NOMTRA,                                        ';

    If blnEtqCaixa Then
    Begin
      strMovGer := strMovGer + '  (SELECT                                          ';
      strMovGer := strMovGer + '    COUNT(DISTINCT V.FGC_CODBAR)                   ';
      strMovGer := strMovGer + '  FROM                                             ';
      strMovGer := strMovGer + '    FGOCAI V                                       ';
      strMovGer := strMovGer + '  WHERE V.FGC_NUMFAT = B.FGC_NUMFAT                ';
      strMovGer := strMovGer + '    AND V.FGC_TIPFAT = B.FGC_TIPFAT                ';
      strMovGer := strMovGer + '    AND V.FGC_EMPFAT = B.FGC_EMPFAT                ';
      strMovGer := strMovGer + '    AND TRIM(IFNULL(V.FGC_CODBAR, "")) <> "") AS VOLUMES ';
    End
    Else
    Begin
      strMovGer := strMovGer + ' 0 AS VOLUMES                                     ';
    End;

    strMovGer := strMovGer + 'FROM MOVGER A                                       ';

    If blnEtqCaixa Then
    Begin
      strMovGer := strMovGer + 'INNER JOIN FGOCAI B ON FGC_NUMFAT = GER_NUMDOC AND ';
      strMovGer := strMovGer + '                       FGC_TIPFAT = GER_ESPDOC AND ';
      strMovGer := strMovGer + '                       FGC_EMPFAT = GER_CODEMP     ';
    End;

    strMovGer := strMovGer + 'INNER JOIN CADCLI C ON CLI_CODCLI = GER_CODCLI       ';
    strMovGer := strMovGer + 'LEFT  JOIN CADTRA D ON TRA_CODTRA = GER_CODTRA       ';

    If blnEtqCaixa Then
    Begin
      strMovGer := strMovGer + 'WHERE FGC_CODBAR = :CODBAR                         ';
    End
    Else
    Begin
      strMovGer := strMovGer + 'WHERE GER_NUMDOC = :NUMDOC                         ';
      strMovGer := strMovGer + '  AND GER_ESPDOC = :ESPDOC                         ';
      strMovGer := strMovGer + '  AND GER_CODEMP = :CODEMP                         ';
    End;

    strNotGer := AnsiReplaceStr(strMovGer, 'MOVGER', 'NOTGER');

    strSQL := strMovGer + ' UNION ALL ' + strNotGer;

    strSQL := strSQL + 'ORDER BY GER_DTAENT, GER_CODEMP, GER_ESPDOC, GER_NUMDOC, GER_VOLUME ';

    With qryDocumentos Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add( strSQL );

      If blnEtqCaixa Then
      Begin
        ParamByName('CODBAR').AsString := strCodBar;
      End
      Else
      Begin
        ParamByName('NUMDOC').AsString  := Copy(strCodBar, 1, fTamDocCadRec);
        ParamByName('ESPDOC').AsString  := fRetornaEspeciePeloCodigo(Copy(strCodBar, 13, 2));
        ParamByName('CODEMP').AsString  := Copy(strCodBar, 15, 3);
      End;

      Open;

      If Not IsEmpty Then
      Begin
         Result := fTravaEspDoc(strCodBar);

        If Result Then
          Result := fTravaRomaneio(FieldByName('GER_NUMDOC').AsString,
                                   FieldByName('GER_ESPDOC').AsString,
                                   FieldByName('GER_CODEMP').AsString);

        If Result Then
          Result := fTravaCodBar(strCodBar);

        If Result Then
          Result := fTravaTransportadora(FieldByName('GER_CODTRA').AsString);

        If Result then
        Begin
          If  ( Not cdsDocumentos.Locate('NUMDOC;ESPDOC;CODEMP', VarArrayOf([FieldByName('GER_NUMDOC').AsString,
                                                                             FieldByName('GER_ESPDOC').AsString,
                                                                             FieldByName('GER_CODEMP').AsString]), [])) Then
          Begin
            cdsDocumentos.Insert;
            cdsDocumentos.FieldByName('OK').AsString         := 'N';
            cdsDocumentos.FieldByName('TABELA').AsString     := FieldByName('TABELA').AsString;
            cdsDocumentos.FieldByName('AUTOINCREM').AsString := FieldByName('AUTOINCREM').AsString;

            cdsDocumentos.FieldByName('DOCUMENTO').AsString  := FieldByName('GER_NUMDOC').AsString + '-' +
                                                                FieldByName('GER_ESPDOC').AsString + '-' +
                                                                FieldByName('GER_CODEMP').AsString ;

            cdsDocumentos.FieldByName('NUMDOC').AsString     := FieldByName('GER_NUMDOC').AsString;
            cdsDocumentos.FieldByName('ESPDOC').AsString     := FieldByName('GER_ESPDOC').AsString;
            cdsDocumentos.FieldByName('CODEMP').AsString     := FieldByName('GER_CODEMP').AsString;
            cdsDocumentos.FieldByName('CODBAR').AsString     := strCodBar;
            cdsDocumentos.FieldByName('DTAENT').AsDateTime   := FieldByName('GER_DTAENT').AsDateTime;
            cdsDocumentos.FieldByName('CODCLI').AsString     := FieldByName('CLI_CODCLI').AsString;
            cdsDocumentos.FieldByName('NOMCLI').AsString     := FieldByName('CLI_NOMCLI').AsString;
            cdsDocumentos.FieldByName('CODVEN').AsString     := FieldByName('GER_CODVEN').AsString;
            cdsDocumentos.FieldByName('CODTRA').AsString     := FieldByName('GER_CODTRA').AsString;
            cdsDocumentos.FieldByName('VLRCON').AsFloat      := FieldByName('GER_VLRCON').AsFloat;

            If blnEtqCaixa Then
            Begin
              cdsDocumentos.FieldByName('QTDVOL').AsInteger    := 1;
              cdsDocumentos.FieldByName('TOTVOL').AsInteger    := FieldByName('VOLUMES').AsInteger;
              cdsDocumentos.FieldByName('VOLUME').AsString     := '1/' + FieldByName('VOLUMES').AsString;
            End
            Else
            Begin
              cdsDocumentos.FieldByName('QTDVOL').AsInteger    := 1;
              cdsDocumentos.FieldByName('TOTVOL').AsInteger    := intTotVol;
              cdsDocumentos.FieldByName('VOLUME').AsString     := '1/' + IntToStr(intTotVol);
            End;
            cdsDocumentos.Post;
          End
          Else
          Begin
            cdsDocumentos.Edit;
            cdsDocumentos.FieldByName('QTDVOL').AsInteger    := cdsDocumentos.FieldByName('QTDVOL').AsInteger + 1 ;
            cdsDocumentos.FieldByName('VOLUME').AsString     := cdsDocumentos.FieldByName('QTDVOL').AsString + '/' +
                                                                cdsDocumentos.FieldByName('TOTVOL').AsString;
            cdsDocumentos.Post;
          End;

          pAddCodBar(strCodBar,
                     FieldByName('GER_NUMDOC').AsString,
                     FieldByName('GER_ESPDOC').AsString,
                     FieldByName('GER_CODEMP').AsString,
                     intSeqVol);

          pDocumentoOK;

        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Não foi possível localizar o documento desse código de barras.'+#13+
                              'Verifique se o documento foi faturado.', ['&Ok']);
        Result := False;
      End;
    End;
  Finally
    FreeAndNil(qryDocumentos);
  End;
End;

end.
