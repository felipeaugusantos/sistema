unit untEntConfPreNotaGarantiaDigRefugo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, untZClient, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, Uni, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGridCitel, cxClasses,
  cxGridLevel, cxGrid, StrUtils, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmEntConfPreNotaGarantiaDigRefugo = class(TfrmPaiConfirma)
    cxgRefugoLevel: TcxGridLevel;
    cxgRefugoTableView: TcxGridDBTableViewCitel;
    cxgRefugo: TcxGridCitel;
    cxgRefugoNUMDOC: TcxGridDBColumn;
    cxgRefugoSERIE_: TcxGridDBColumn;
    cxgRefugoDTAENT: TcxGridDBColumn;
    cxgRefugoCODITE: TcxGridDBColumn;
    cxgRefugoDESITE: TcxGridDBColumn;
    cxgRefugoCODFAB: TcxGridDBColumn;
    cxgRefugoREFERE: TcxGridDBColumn;
    cxgRefugoSIGUNI: TcxGridDBColumn;
    cxgRefugoQTDITE: TcxGridDBColumn;
    cxgMovGaeLevel1: TcxGridLevel;
    cxgMovGaeTableView: TcxGridDBTableViewCitel;
    cxgMovGae: TcxGridCitel;
    Splitter1: TSplitter;
    cxgMovGaeNUMENV: TcxGridDBColumn;
    cxgMovGaeESPENV: TcxGridDBColumn;
    cxgMovGaeSERENV: TcxGridDBColumn;
    cxgMovGaeDTAENV: TcxGridDBColumn;
    cxgMovGaeQTDENV: TcxGridDBColumn;
    cxgMovGaeNOMCLI: TcxGridDBColumn;
    cxgMovGaeQTDRET: TcxGridDBColumn;
    cxgMovGaeQTDREF: TcxGridDBColumn;
    cxgMovGaeRETCON: TcxGridDBColumn;
    cxgMovGaeREFCON: TcxGridDBColumn;
    Label1: TLabel;
    Label2: TLabel;
    procedure cxgRefugoExit(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxgMovGaeTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    cdsRefugo : TZClient;
    cdsMovGae : TUniClientDataSet;
    dtsMovGae : TDataSource;
    function fGetSQL(stlAutIncGerEle : TStringList):String;
    function fGetSQLMovGae : String;
    procedure pBeforePost(DataSet : TDataSet);
    procedure pBeforePostMovGae(DataSet : TDataSet);
    procedure pAfterScroll(DataSet: TDataSet);
    procedure pMontaMovGae;
    function fVerificaQuantidades : Boolean;
  public
    class function fDigitaRefugos(stlAutIncGerEle : TStringList) : Boolean;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples;

{ TfrmEntConfPreNotaGarantiaDigRefugo }

procedure TfrmEntConfPreNotaGarantiaDigRefugo.btnConfirmaClick(Sender: TObject);
  Var
    qryUpdate : TUniQuery;
begin
  Try
    cdsRefugo.CheckBrowseMode;
    cdsRefugo.DisableControls;

    qryUpdate := fCriaQuery(Self);

    If not fVerificaQuantidades Then
      Exit;

    With qryUpdate, SQL Do
    Begin
      cdsMovGae.CheckBrowseMode;
      cdsMovGae.DisableControls;

      cdsRefugo.First;
      While Not cdsRefugo.Eof Do
      Begin
        cdsMovGae.First;
        While not cdsMovGae.Eof Do
        Begin
          Close;
          Clear;
          Add(' UPDATE MOVGAE SET GAE_RETCON = IFNULL(GAE_RETCON,0) + :RETCON, ');
          Add('                   GAE_REFCON = IFNULL(GAE_REFCON,0) + :REFCON  ');
          Add(' WHERE AUTOINCREM = :AUTINC                                     ');

          ParamByName('RETCON').AsFloat  := cdsMovGae.FieldByName('RETCON').AsFloat;
          ParamByName('REFCON').AsFloat  := cdsMovGae.FieldByName('REFCON').AsFloat;
          ParamByName('AUTINC').AsString := cdsMovGae.FieldByName('AUTOINCREM').AsString;
          ExecSQL;

          Close;
          Clear;
          Add(' UPDATE DETELE SET DET_QTDREF = IFNULL(DET_QTDREF,0) + :QTDREF WHERE AUTOINCREM = :AUTINC ');

          ParamByName('QTDREF').AsFloat  := cdsMovGae.FieldByName('REFCON').AsFloat;
          ParamByName('AUTINC').AsString := cdsRefugo.FieldByName('AUTINC').AsString;
          ExecSQL;

          cdsMovGae.Next;
        End;

        cdsRefugo.Next;
      End;

      ModalResult := MrOk;

    End;

  Finally
    cdsRefugo.EnableControls;
    FreeAndNil(qryUpdate);

    if Assigned(cdsMovGae) Then
      cdsMovGae.EnableControls;

  End;
end;

procedure TfrmEntConfPreNotaGarantiaDigRefugo.cxgMovGaeTableViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (cxgMovGaeRETCON.Focused) And ((Key = VK_RETURN) Or (Key = VK_RIGHT)) Then
    cxgMovGaeREFCON.Focused:= True
  Else
  If (cxgMovGaeREFCON.Focused) And ((Key = VK_RETURN) Or (Key = VK_LEFT)) Then
    cxgMovGaeRETCON.Focused:= True;
end;

procedure TfrmEntConfPreNotaGarantiaDigRefugo.cxgRefugoExit(Sender: TObject);
begin
  inherited;
  cdsRefugo.CheckBrowseMode;
end;

class function TfrmEntConfPreNotaGarantiaDigRefugo.fDigitaRefugos(stlAutIncGerEle: TStringList): Boolean;
  var
    frmFrm : TfrmEntConfPreNotaGarantiaDigRefugo;
begin
  Result := False;
  If stlAutIncGerEle.Count <= 0 Then
    Exit;

  pCriarFormularios(TfrmEntConfPreNotaGarantiaDigRefugo,frmFrm);
  With frmFrm Do
  Begin
    cdsRefugo := TZClient.Create(frmFrm, fGetSQL(stlAutIncGerEle));
    cdsRefugo.fAbreClient(True);

    If Not cdsRefugo.IsEmpty Then
    Begin
      TFLoatField(cdsRefugo.FieldByName('QTDITE')).DisplayFormat := '#,##0.00';
      TFLoatField(cdsRefugo.FieldByName('QTDREF')).DisplayFormat := '#,##0.00';
      cdsRefugo.BeforePost := pBeforePost;

      cxgRefugoTableView.DataController.DataSource := cdsRefugo.dtsSource;
      cxgRefugoTableView.ApplyBestFit();

      pMontaMovGae;

      Result := (frmFrm.ShowModal = MrOk);
    End;

    FreeAndNil(cdsRefugo);

    If Assigned(dtsMovGae) Then
      FreeAndNil(dtsMovGae);

    If Assigned(cdsMovGae) Then
      FreeAndNil(cdsMovGae);
  End;
  FreeAndNil(frmFrm);

end;

procedure TfrmEntConfPreNotaGarantiaDigRefugo.pMontaMovGae;
  Var
    qryDados : TUniQuery;
    intIndex : Integer;
Begin
  Try
    qryDados := fCriarQuery(fGetSQLMovGae);

    cdsRefugo.First;

    qryDados.Close;
    qryDados.ParamByName('SEQELE').AsString := cdsRefugo.FieldByName('DET_SEQGER').AsString;
    qryDados.ParamByName('CODITE').AsString := cdsRefugo.FieldByName('CODITE').AsString;
    qryDados.Open;


    cdsMovGae := fCriaClientDatset(qryDados, True);
    dtsMovGae := fCriaDataSource(cdsMovGae);
    cdsMovGae.BeforePost := pBeforePostMovGae;

    cxgMovGaeTableView.DataController.DataSource := dtsMovGae;

    While Not cdsRefugo.Eof Do
    Begin
      qryDados.Close;
      qryDados.ParamByName('SEQELE').AsString := cdsRefugo.FieldByName('DET_SEQGER').AsString;
      qryDados.ParamByName('CODITE').AsString := cdsRefugo.FieldByName('CODITE').AsString;
      qryDados.Open;

      While not qryDados.Eof Do
      Begin
        cdsMovGae.Append;

        For intIndex := 0 To cdsMovGae.Fields.Count - 1 Do
          cdsMovGae.Fields[intIndex].Value := qryDados.Fields[intIndex].Value;

        cdsMovGae.Post;

        qryDados.Next;
      End;

      cdsRefugo.Next;
    End;


    cdsRefugo.First;
    cdsRefugo.AfterScroll := pAfterScroll;
    pAfterScroll(cdsRefugo);

    TFloatField(cdsMovGae.FieldByName('QTDRET')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsMovGae.FieldByName('QTDREF')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsMovGae.FieldByName('RETCON')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsMovGae.FieldByName('REFCON')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsMovGae.FieldByName('QTDENV')).DisplayFormat := '#,##0.0000';

  Finally
    FreeAndNiL(qryDados);
  End;
End;

procedure TfrmEntConfPreNotaGarantiaDigRefugo.pAfterScroll(DataSet : TDataSet);
Begin
  cdsMovGae.Filtered := False;
  cdsMovGae.Filter := ' PEL_SEQELE = ' + QuotedStr(cdsRefugo.FieldByName('DET_SEQGER').AsString) +
                      ' AND CODITE = ' + QuotedStr(cdsRefugo.FieldByName('CODITE').AsString);
  cdsMovGae.Filtered := True;
End;

function TfrmEntConfPreNotaGarantiaDigRefugo.fGetSQL(stlAutIncGerEle: TStringList): String;
  Var
    intIndex : Integer;
begin
  Result := '';
  Result := Result + ' SELECT DISTINCT                                       ';
  Result := Result + '        B08_NNF    AS NUMDOC,                          ';
  Result := Result + '        B07_SERIE  AS SERIE_,                          ';
  Result := Result + '        B09_DEMI   AS DTAENT,                          ';
  Result := Result + '        DET_CODITE AS CODITE,                          ';
  Result := Result + '        ITE_DESITE AS DESITE,                          ';
  Result := Result + '        ITE_CODFAB AS CODFAB,                          ';
  Result := Result + '        ITE_REFERE AS REFERE,                          ';
  Result := Result + '        UNI_SIGUNI AS SIGUNI,                          ';
  Result := Result + '        SUM(I10_QCOM)   AS QTDITE,                     ';
  Result := Result + '        DET_QTDREF AS QTDREF,                          ';
  Result := Result + '        D.AUTOINCREM AS AUTINC,                        ';
  Result := Result + '        DET_SEQGER                                     ';
  Result := Result + ' FROM DETELE D                                         ';
  Result := Result + '   INNER JOIN GERELE ON GERELE.AUTOINCREM = DET_SEQGER ';
  Result := Result + '   LEFT  JOIN CADITE ON ITE_CODITE = DET_CODITE        ';
  Result := Result + '   LEFT  JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI        ';


  If (stlAutIncGerEle.Count = 1) Then
    Result := Result + ' WHERE DET_SEQGER = ' + QuotedStr(stlAutIncGerEle[0])
  Else
  Begin
    Result := Result + ' WHERE DET_SEQGER IN( ';
    For intIndex := 0 To stlAutIncGerEle.Count - 1 Do
    Begin
      Result := Result + QuotedStr(stlAutIncGerEle[intIndex]);
      If intIndex < stlAutIncGerEle.Count - 1 Then
        Result := Result + ', ';
    End;
  End;

  Result := Result + ' GROUP BY DET_SEQGER, CODITE';

end;

function TfrmEntConfPreNotaGarantiaDigRefugo.fGetSQLMovGae: String;
begin
  Result := '';
  Result := Result + ' SELECT DISTINCT                                                                       ';
  Result := Result + '        GAE_NUMENV AS NUMENV,                                                          ';
  Result := Result + '        GAE_ESPENV AS ESPENV,                                                          ';
  Result := Result + '        GAE_EMPENV AS EMPENV,                                                          ';
  Result := Result + '        GAE_SERENV AS SERENV,                                                          ';
  Result := Result + '        GAE_DTAENV AS DTAENV,                                                          ';
  Result := Result + '        IFNULL(GAE_QTDENV,0) - IFNULL(GAE_RETCON,0) - IFNULL(GAE_REFCON,0) AS QTDENV,  ';
  Result := Result + '        GAE_PRECUS AS PRECUS,                                                          ';
  Result := Result + '        GAD_CODITE AS CODITE,                                                          ';
  Result := Result + '        CLI_NOMCLI AS NOMCLI,                                                          ';
  Result := Result + '        GAE_QTDRET AS QTDRET,                                                          ';
  Result := Result + '        GAE_QTDREF AS QTDREF,                                                          ';
  Result := Result + '        CAST(0.00 AS DECIMAL(12,4)) AS RETCON,                                         ';
  Result := Result + '        CAST(0.00 AS DECIMAL(12,4)) AS REFCON,                                         ';
  Result := Result + '        MOVGAE.AUTOINCREM,                                                             ';
  Result := Result + '        PEL_SEQELE                                                                     ';
  Result := Result + ' FROM PEDELE                                                                           ';
  Result := Result + '  INNER JOIN PCMDET ON PCD_NUMPED = PEL_NUMDOC                                         ';
  Result := Result + '                   AND PCD_ESPDOC = PEL_ESPDOC                                         ';
  Result := Result + '                   AND PCD_CODEMP = PEL_CODEMP                                         ';
  Result := Result + '                   AND PCD_CODFOR = PEL_CODFOR                                         ';
  Result := Result + '  INNER JOIN MOVGAE ON GAE_NUMENV = SUBSTR(PCD_DOCORI, 01, 12)                         ';
  Result := Result + '                   AND GAE_ESPENV = SUBSTR(PCD_DOCORI, 13, 02)                         ';
  Result := Result + '                   AND GAE_EMPENV = SUBSTR(PCD_DOCORI, -3)                             ';
  Result := Result + '  INNER JOIN MOVGAD D ON D.AUTOINCREM = GAE_SEQGAD                                     ';
  Result := Result + '                     AND GAD_CODITE = PCD_CODITE                                       ';
  Result := Result + '  INNER JOIN MOVGAG G ON G.AUTOINCREM = GAD_SEQGAG                                     ';
  Result := Result + '  INNER JOIN CADCLI C ON C.CLI_CODCLI = GAG_CODCLI                                     ';
  Result := Result + ' WHERE PEL_SEQELE = :SEQELE                                                            ';
  Result := Result + '   AND PCD_CODITE = :CODITE                                                            ';
  Result := Result + ' HAVING                                                                                ';
  Result := Result + '   QTDENV > 0                                                                          ';
end;

procedure TfrmEntConfPreNotaGarantiaDigRefugo.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Shift = [ssCtrl] Then
  Begin
    If Key = Ord('N') Then
      pSetFocus(cxgRefugo)
    Else If Key = Ord('M') Then
      pSetFocus(cxgMovGae);
  End;
end;

procedure TfrmEntConfPreNotaGarantiaDigRefugo.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(cxgRefugo);
end;

function TfrmEntConfPreNotaGarantiaDigRefugo.fVerificaQuantidades: Boolean;
  Var
    fltQtdRet : Currency;
begin
  Try
    cdsMovGae.DisableControls;
    cdsRefugo.DisableControls;
    cdsRefugo.First;
    While Not cdsRefugo.Eof Do
    Begin
      fltQtdRet := 0;
      While Not cdsMovGae.Eof Do
      Begin
        fltQtdRet := fltQtdRet + cdsMovGae.FieldByName('RETCON').AsFloat +
                                 cdsMovGae.FieldByName('REFCON').AsFloat;

        cdsMovGae.Next;

      End;

      If (cdsRefugo.FieldByName('QTDITE').AsFloat <> fltQtdRet) Then
      Begin
        pMensagemOK('A Quantidade de Retorno e refugo do item ' + cdsRefugo.FieldByName('CODITE').AsString +  ' - ' +
                    cdsRefugo.FieldByName('DESITE').AsString +
                    ' deve bater com a quantidade da nota fiscal, corrija para continuar!' + #13 +
                    'Quantidade da Nota Fiscal: ' + FormatFloat('#,##0.0000', cdsRefugo.FieldByName('QTDITE').AsFloat) +
                    ' Quantidade digitada do Retorno + Refugo : ' + FormatFloat('#,##0.0000', fltQtdRet));

        Exit(False);
      End;

      cdsRefugo.Next;
    End;

    Result := True;

  Finally
    cdsRefugo.First;
    cdsMovGae.First;
    cdsRefugo.EnableControls;
    cdsMovGae.EnableControls;
  End;
end;

procedure TfrmEntConfPreNotaGarantiaDigRefugo.pBeforePost(DataSet: TDataSet);
begin
  If cdsRefugo.FieldByName('QTDITE').AsFloat < cdsRefugo.FieldByName('QTDREF').AsFloat Then
  Begin
    fMensagem('','A quantidade de refugo não pode ser maior que a quantidade da nota fiscal!', ['&Ok']);
    cdsRefugo.FieldByName('QTDREF').AsFloat := cdsRefugo.FieldByName('QTDITE').AsFloat;
    pSetFocus(cxgRefugo);
  End

  Else If cdsRefugo.FieldByName('QTDREF').AsFloat < 0 Then
    cdsRefugo.FieldByName('QTDREF').AsFloat := 0;

end;

procedure TfrmEntConfPreNotaGarantiaDigRefugo.pBeforePostMovGae(DataSet: TDataSet);
begin
  If (DataSet.FieldByName('QTDENV').AsFloat <
      DataSet.FieldByName('QTDRET').AsFloat +
      DataSet.FieldByName('QTDREF').AsFloat +
      DataSet.FieldByName('RETCON').AsFloat +
      DataSet.FieldByName('REFCON').AsFloat ) Then
  Begin
    pMensagemOK('O Total da quantidade ja retornado mais a quantidade retornada não pode ultrapassar a quantidade enviada para o fornecedor!');
    Abort;
  End;

end;

end.

