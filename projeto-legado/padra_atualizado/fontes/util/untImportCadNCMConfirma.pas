unit untImportCadNCMConfirma;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Data.DB, untZClient, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxGridLevel, cxClasses, cxGridCustomView, Uni,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxGridCitel, cxCurrencyEdit, cxContainer, cxProgressBar,
  cxCheckBox, System.StrUtils;

type
  TAcaoImpCadNcm = (tpSem, tpInserir,  tpAtualizar);


  TfrmImportCadNCMConfirma = class(TfrmPaiConfirma)
    dtsCadNcm: TDataSource;
    grpLegenda: TGroupBox;
    Shape2: TShape;
    Shape3: TShape;
    Label2: TLabel;
    Label3: TLabel;
    cxgNcmDBTableView1: TcxGridDBTableView;
    cxgNcmLevel1: TcxGridLevel;
    cxgNcm: TcxGrid;
    cxgNcmNCM: TcxGridDBColumn;
    cxgNcmDBCODEXC: TcxGridDBColumn;
    cxgNcmDBALQIPI: TcxGridDBColumn;
    cxgNcmDBDESCRI: TcxGridDBColumn;
    cxgNcmDBANVOBR: TcxGridDBColumn;
    cxgNcmDBABVIcms: TcxGridDBColumn;
    cxgNcmDBABVPIS: TcxGridDBColumn;
    cxgNcmDBABVCOFINS: TcxGridDBColumn;
    cxgNcmDBABVIPI: TcxGridDBColumn;
    cxgNcmDBACAO: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxgNcmDBTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    qryExec: TUniQuery;
    function fTrataCodigoInterno(strValue: String): string;
    { Private declarations }
  protected
    function  fInsereNcms(pgbProgresso: TcxProgressBar): Boolean;
    procedure pGravaCadNcm;
    procedure pGravaAbreviacoes;
    procedure pGravaAbf(strTabela: String);

    function fTrataVazio(strValor: Variant; ValorDef: Variant ): Variant;

  public
    cdsCadNcm: TZClient;
    blnOk: Boolean;
    { Public declarations }
  end;

  function fAcaoImpCadNCMToStr(ATAcaoImpCadNCM: TAcaoImpCadNcm): String;
  function fGetAcao(AAcaoStr: String): TAcaoImpCadNcm;


var
  frmImportCadNCMConfirma: TfrmImportCadNCMConfirma;

implementation

uses
  untGravando, untFuncoesSimples;


function fAcaoImpCadNCMToStr(ATAcaoImpCadNCM: TAcaoImpCadNcm): String;
Begin
  Result := '';
  case ATAcaoImpCadNCM of
   tpSem: Result := '';
   tpInserir: Result := 'I';
   tpAtualizar: Result := 'A';
  end;

End;

function fGetAcao(AAcaoStr: String): TAcaoImpCadNcm;
begin
  Result := tpSem;
  case AnsiIndexStr(AAcaoStr, ['I', 'A', '']) of
   0: Result := tpInserir;
   1: Result := tpAtualizar;
   2: Result := tpSem;
  end;
End;

{$R *.dfm}

procedure TfrmImportCadNCMConfirma.btnConfirmaClick(Sender: TObject);
var  frmIns: TfrmGravando;
begin
  inherited;
  If cdsCadNcm.RecordCount > 0 then
  Begin
    pCriarFormularios(TfrmGravando, frmIns);
    Try
      frmIns.fExecutarAcao := fInsereNcms;
      frmIns.lblGravando.Caption := 'Aguarde... processando NCMs...';
      frmIns.Showmodal;
      If blnOk Then
        pMensagemOk('Processo concluído com êxito!');
    Finally
      pFreeAndNil(frmIns);
    End;
  End;
end;

procedure TfrmImportCadNCMConfirma.cxgNcmDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  var
    strAcao: String;
    AcaoImpCadNcm : TAcaoImpCadNcm;
begin
  inherited;
  If cdsCadNcm.RecordCount = 0 Then
    Exit;

  strAcao := VarToString(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgNcmDBACAO.Index]);

  AcaoImpCadNcm := fGetAcao(strAcao);
  ACanvas.Font.Color := clBlack;

  Case AcaoImpCadNcm Of
    tpInserir:  ACanvas.Brush.Color := clAqua;
    tpAtualizar: ACanvas.Brush.Color := clYellow;
    Else
      ACanvas.Brush.Color := clMoneyGreen;
  End;
end;

function TfrmImportCadNCMConfirma.fInsereNcms(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := False;
  pgbProgresso.Properties.Max := cdsCadNcm.RecordCount;
  cdsCadNcm.First;
  cdsCadNcm.DisableControls;
  fStartTransaction;
  blnOk := False;
  Try
    Try
      While not cdsCadNcm.Eof Do
      Begin
        pGravaCadNcm;
        pGravaAbreviacoes;
        cdsCadNcm.Next;
      End;
      fCommit;
      blnOk := True;
      Result := True;
    Except
      On e: Exception do
      Begin
        fRollBack;
        pMensagensErro(e.Message, '[TfrmImportCadNCMConfirma.fInsereNcms]');
      End;
    End

  Finally
    cdsCadNcm.EnableControls;
  End;
end;

procedure TfrmImportCadNCMConfirma.FormCreate(Sender: TObject);
begin
  inherited;
  qryExec := fCriaQuery;
  blnOk := False;
end;

procedure TfrmImportCadNCMConfirma.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryExec);
end;

procedure TfrmImportCadNCMConfirma.FormShow(Sender: TObject);
begin
  inherited;
  dtsCadNcm.DataSet := cdsCadNcm;
  cxgNcmDBTableView1.ApplyBestFit;
end;

function TfrmImportCadNCMConfirma.fTrataCodigoInterno(strValue: String): string;
Begin
  strValue := strValue.Replace('.', '');
  Result := strValue;
  If Result = '00000000' Then
    Exit;
  While Result[Length(Result)] = '0' do
  Begin
    Delete(Result,Length(Result),1);
  End;
End;

procedure TfrmImportCadNCMConfirma.pGravaCadNcm;
var
  blnInclusao: Boolean;
  strAutInc: String;
  const
    cFieldsIns =  'AUTOINCREM, NCM_CODNCM, NCM_CODTRA, NCM_CODEXC, NCM_DESCRI, NCM_ALQIPI, NCM_ANVOBR';
    cParamnsIns = ':AUTOINCREM, :NCM_CODNCM, :NCM_CODTRA, :NCM_CODEXC, :NCM_DESCRI, :NCM_ALQIPI, :NCM_ANVOBR';

    cUpdate  = ' NCM_DESCRI = :NCM_DESCRI,' +
               ' NCM_ALQIPI = :NCM_ALQIPI,' +
               ' NCM_ANVOBR = :NCM_ANVOBR';

begin
  blnInclusao := cdsCadNcm.FieldByName('ACAO').AsString = 'I';
  qryExec.SQL.Clear;
  If blnInclusao Then
  Begin
    qryExec.SQL.Add('INSERT CADNCM (' + cFieldsIns + ') VALUES ('+cParamnsIns+')');
    strAutInc := fRetAutoIncrem('CADNCM', VS_StrCodEmp);
  End
  Else
  Begin
    strAutInc := cdsCadNcm.FieldByName('AUTOINCREM').AsString;
    qryExec.SQL.Add('UPDATE CADNCM SET ' + cUpdate);
    qryExec.SQL.Add(' WHERE AUTOINCREM = :AUTOINCREM');
  End;

  qryExec.ParamByName('AUTOINCREM').AsString := strAutInc;

  If blnInclusao THen
  Begin
    qryExec.ParamByName('NCM_CODNCM').AsString := cdsCadNcm.FieldByName('NCM_CODNCM').AsString;
    qryExec.ParamByName('NCM_CODEXC').AsString := cdsCadNcm.FieldByName('NCM_CODEXC').AsString;
    qryExec.ParamByName('NCM_CODTRA').AsString := fTrataCodigoInterno(cdsCadNcm.FieldByName('NCM_CODNCM').AsString);
  End;

  qryExec.ParamByName('NCM_DESCRI').AsString := cdsCadNcm.FieldByName('NCM_DESCRI').AsString;
  qryExec.ParamByName('NCM_ALQIPI').AsString := cdsCadNcm.FieldByName('NCM_ALQIPI').AsString;
  qryExec.ParamByName('NCM_ANVOBR').AsString := cdsCadNcm.FieldByName('NCM_ANVOBR').AsString;
 
  qryExec.ExecSQL;
end;

procedure TfrmImportCadNCMConfirma.pGravaAbreviacoes;
begin
  pGravaAbf('NCMICM');
  pGravaAbf('NCMCOF');
  pGravaAbf('NCMIPI');
  pGravaAbf('NCMPIS');
end;

procedure TfrmImportCadNCMConfirma.pGravaAbf(strTabela: String);
var
  strCodNcm,
  strCampo,
  strCodExc,
  strCodAbf: String;
  I: Integer;
  lst: TStringList;
begin
  strCodNcm := cdsCadNcm.FieldByName('NCM_CODNCM').AsString;
  strCodExc := cdsCadNcm.FieldByName('NCM_CODEXC').AsString;
  strCampo := 'LIS' + Copy(strTabela, 4, 3);

  If Not fEmptyStr(cdsCadNcm.FieldByName(strCampo).AsString) Then
  Begin
    Try
      lst := TStringList.Create;
      lst.Text := '';
      lst.StrictDelimiter := True;
      lst.Delimiter := ',';
      lst.DelimitedText := cdsCadNcm.FieldByName(strCampo).AsString;

      For i := 0 To Pred(lst.Count) do
      Begin
        strCodAbf := Trim(lst[i]);

        qryExec.SQL.Clear;
        qryExec.SQL.Add('SELECT * FROM ' + strTabela );
        qryExec.SQL.Add('WHERE NCM_CODEXC = ' + QuotedStr(strCodExc));
        qryExec.SQL.Add('  AND NCM_CODNCM = ' + QuotedStr(strCodNcm));
        qryExec.SQL.Add('  AND NCM_CODABF = ' + QuotedStr(strCodAbf));
        qryExec.Open;

        If qryExec.isEmpty Then
        Begin
          qryExec.SQL.Clear;
          qryExec.SQL.Add('INSERT INTO ' + strTabela + ' (AUTOINCREM, NCM_CODNCM, NCM_CODEXC, NCM_CODABF) VALUES (:AUTINC, :NCM, :EXC, :ABF)');
          qryExec.ParamByName('AUTINC').AsString := fRetAutoIncrem(strTabela, VS_StrCodEmp);
          qryExec.ParamByName('NCM').AsString := strCodNcm;
          qryExec.ParamByName('EXC').AsString := strCodExc;
          qryExec.ParamByName('ABF').AsString := strCodAbf;

          qryExec.ExecSQL;
        End;
      End;
    Finally
      FreeAndNil(lst);
    End;
  End;
End;

function TfrmImportCadNCMConfirma.fTrataVazio(strValor: Variant; ValorDef: Variant): Variant;
begin
  If strValor = null Then
    Exit(ValorDef);

  If VarToStrDef(strValor, '') = '' Then
    Result := ValorDef
  Else
     Result := strValor;
end;

end.





