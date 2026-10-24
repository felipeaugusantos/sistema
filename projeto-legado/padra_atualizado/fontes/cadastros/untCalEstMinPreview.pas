unit untCalEstMinPreview;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.Grids, Vcl.DBGrids, System.UITypes,
  Vcl.StdCtrls, EditFocus, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Data.DB,
  Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, untZClient,
  Uni, StrUtils, DbGridCitel, DBAccess, Datasnap.DBClient, UniClientDataSet,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCalc,
  untGravando;

type
  TFrmCalEstMinPreview = class(TfrmPaiSimples)
    pnlBotoesMostra: TPanel;
    dsDados: TUniDataSource;
    gridDadosView: TcxGridDBTableView;
    gridDadosLevel: TcxGridLevel;
    gridDados: TcxGrid;
    gridDadosViewColumn1: TcxGridDBColumn;
    gridDadosViewColumn2: TcxGridDBColumn;
    gridDadosViewColumn3: TcxGridDBColumn;
    gridDadosViewColumn4: TcxGridDBColumn;
    gridDadosViewColumn5: TcxGridDBColumn;
    gridDadosViewColumn6: TcxGridDBColumn;
    gridDadosViewColumn7: TcxGridDBColumn;
    gridDadosViewColumn8: TcxGridDBColumn;
    btnCancelar: TBitBtnLocked;
    btnGerar: TBitBtnLocked;
    lblLegendaDeletar: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGerarClick(Sender: TObject);
  private
    procedure DadosBeforePost(Dataset: TDataset);
    procedure pAdicionaColunasGiro;
  public
    FDados : TUniClientDataset;
    function fAdicionaScriptEmpresa(var AScript: string; const AEmpresa : String): String;
    function fAtualizaEmpresa(const AEmpresa : String; frmGravando: TfrmGravando): Boolean;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untAltEst;

{ TFrmCalEstMinPreview }

procedure TFrmCalEstMinPreview.btnCancelarClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TFrmCalEstMinPreview.btnGerarClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrOk;
end;

procedure TFrmCalEstMinPreview.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(gridDados);
  dsDados.Dataset := FDados;
  pAdicionaColunasGiro;
  FDados.BeforePost := DadosBeforePost;
  TFloatField(FDados.FieldByName('ESTMIN')).DisplayFormat := fDisplayFormat(2);
  TFloatField(FDados.FieldByName('ESTMAX')).DisplayFormat := fDisplayFormat(2);
  gridDadosView.DataController.Groups.FullExpand;
  FDados.First;
end;

procedure TFrmCalEstMinPreview.DadosBeforePost(Dataset : TDataset);
begin
  If Dataset.FieldByName('ESTMIN').AsFloat > Dataset.FieldByName('ESTMAX').AsFloat Then
  Begin
    fMensagem('ERRO', 'Valor do estoque mínimo não pode ser menor que o valor do estoque máximo!!', ['&O k']);
    Abort;
  End;
end;

procedure TFrmCalEstMinPreview.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If ModalResult <> mrOk Then
    If fMensagem('AVISO', 'Deseja cancelar o cálculo de estoque mínimo?', ['&Sim', '&Não']) <> 1 Then
      Action := caNone;
end;

procedure TFrmCalEstMinPreview.FormDestroy(Sender: TObject);
begin
  if Assigned(FDados) then
    FreeAndNil(FDados);
  inherited;
end;

procedure TFrmCalEstMinPreview.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
    Close;
end;

function TFrmCalEstMinPreview.fAdicionaScriptEmpresa(var AScript: string; const AEmpresa : String): String;
  Var
    strSql : String;
begin
  strSql := EmptyStr;
  FDados.DisableControls; // nao precisa habilitar novamente.. vai ser destruido logo em seguida.
  FDados.CheckBrowseMode;
  FDados.Filter   := 'ITE_CODEMP=' + QuotedStr(AEmpresa);
  FDados.Filtered := True;
  FDados.First;
  While Not FDados.Eof Do
  Begin
    If (FDados.UpdateStatus = usMOdified) Or
       ((FDados.FieldByName('ITE_ESTMIN').AsFloat <> FDados.FieldByName('ESTMIN').AsFloat) Or
        (FDados.FieldByName('ITE_ESTMAX').AsFloat <> FDados.FieldByName('ESTMAX').AsFloat))  then
      strSql := strSql + #13 +
        ' UPDATE ITEGER G ' +
        '    SET G.ITE_ESTMIN = ' + fFloatToSQL(FDados.FieldByName('ESTMIN').AsFloat) + ', ' +
        '        G.ITE_ESTMAX = ' + fFloatToSQL(FDados.FieldByName('ESTMAX').AsFloat) +
        '  WHERE G.ITE_CODITE = ' + QuotedStr(FDados.FieldByName('ITE_CODITE').AsString) +
        '    AND G.ITE_CODEMP = ' + QuotedStr(FDados.FieldByName('ITE_CODEMP').AsString) + ';';
    FDados.Next;
  End;
  Result := Format(AScript, [strSql]);
end;

function TFrmCalEstMinPreview.fAtualizaEmpresa(const AEmpresa : String; frmGravando: TfrmGravando): Boolean;
  Var
    strAutInc,
    strSql : String;
    qryUpdate: TUniQuery;
begin
  Result := True;

  Try
    qryUpdate := fCriaQuery;

    FDados.DisableControls; // nao precisa habilitar novamente.. vai ser destruido logo em seguida.
    FDados.CheckBrowseMode;
    FDados.Filter   := 'ITE_CODEMP = ' + QuotedStr(AEmpresa) + ' AND (ITE_ESTMIN <> ESTMIN OR ITE_ESTMAX <> ESTMAX)';
    FDados.Filtered := True;
    FDados.First;

    frmGravando.lblGravando.Caption := 'Atualizando empresa ' + AEmpresa + ', aguarde...';
    frmGravando.pgbStatus.Position := 0;
    frmGravando.pgbStatus.Properties.Max := FDados.RecordCount;
    Application.ProcessMessages;

    strAutInc := fRetAutoIncrem('ALTEST', VS_strCodEmp, FDados.RecordCount);

    VS_blnGravaLogTransacao := False;
    VS_GravaUsuRep := 'N';

    While Not FDados.Eof Do
    Begin
      fStartTransaction;

      Try
        strSql :=
          ' UPDATE ITEGER G ' +
          '    SET G.ITE_ESTMIN = ' + fFloatToSQL(FDados.FieldByName('ESTMIN').AsFloat) + ', ' +
          '        G.ITE_ESTMAX = ' + fFloatToSQL(FDados.FieldByName('ESTMAX').AsFloat) +
          '  WHERE G.ITE_CODITE = ' + QuotedStr(FDados.FieldByName('ITE_CODITE').AsString) +
          '    AND G.ITE_CODEMP = ' + QuotedStr(FDados.FieldByName('ITE_CODEMP').AsString) + '; '

          + TAltEst.fSQLInsertLog(strAutInc, AEmpresa, FDados.FieldByName('ITE_CODITE').AsString,
              FDados.FieldByName('ITE_ESTMIN').AsString, FDados.FieldByName('ESTMIN').AsString,
              FDados.FieldByName('ITE_ESTMAX').AsString, FDados.FieldByName('ESTMAX').AsString);

         qryUpdate.Close;
         qryUpdate.SQL.Text := strSql;
         qryUpdate.Execute;

         fCommit;

         strAutInc := fNextAutoIncrem(strAutInc);

       Except

         On E: Exception Do
         Begin
           fRollBack;

           VS_blnGravaLogTransacao := True;
           VS_GravaUsuRep := 'S';

           Result := False;
           pMensagensErro(E.Message, 'TfrmCalEstMin.fAtualizaPrg');

           Exit;
         End;

       End;

      FDados.Next;

      frmGravando.pgbStatus.Position := frmGravando.pgbStatus.Position + 1;

      If (Trunc(frmGravando.pgbStatus.Position) Mod 100) = 0 Then
        Application.ProcessMessages;
    End;

    FreeAndNil(qryUpdate);

  Finally
    VS_blnGravaLogTransacao := True;
    VS_GravaUsuRep := 'S';
   End;
end;

procedure TFrmCalEstMinPreview.pAdicionaColunasGiro;
Var
  intCont: Integer;
  strNomCam: String;
begin
  For intCont := 0 To FDados.Fields.Count - 1 Do
  Begin
    strNomCam := FDados.Fields[intCont].FieldName;
    If (Pos('MES_', strNomCam) > 0) Then
    Begin
      With gridDadosView.CreateColumn Do
      Begin
        DataBinding.FieldName := strNomCam;
        Caption := Copy(strNomCam, 5, 2) + '/' + Copy(strNomCam, 7, 4);
        Options.Editing := False;
      End;
    End;
  End;
end;

end.
