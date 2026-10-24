unit untCfgQuadroAcompanhamentoOS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, cxButtonEdit,
  Uni, UniClientDataSet, cxImageComboBox, System.ImageList, Vcl.ImgList,
  cxImageList, cxSpinEdit;

type
  TfrmCfgQuadroAcompanhamentoOS = class(TfrmPaiConfirma)
    btnAddQuadro: TBitBtnLocked;
    cxGridDBTBV: TcxGridDBTableViewCitel;
    cxGridLevel1: TcxGridLevel;
    cxGrid: TcxGridCitel;
    cxGridDBTBVQUADRO: TcxGridDBColumn;
    cxGridDBTBVSTATUS: TcxGridDBColumn;
    cxGridDBTBVBTNADD: TcxGridDBColumn;
    cxGridDBTBVBTNLIM: TcxGridDBColumn;
    dtsGrid: TDataSource;
    btnDelQuadro: TBitBtnLocked;
    cxGridDBTBVQTDIAS: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnDelQuadroClick(Sender: TObject);
    procedure btnAddQuadroClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxGridDBTBVBTNLIMPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxGridDBTBVBTNADDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    { Private declarations }
    cdsGrid: TUniClientDataSet;
    procedure pCriaDataSet;
    procedure pCarregaDataSet;
    procedure cdsGridNovoRegistro(DataSet: TDataSet);
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, untSelStatusAcompanhamentoOS;

{$R *.dfm}

{ TfrmCfgQuadroAcompanhamentoOS }

procedure TfrmCfgQuadroAcompanhamentoOS.btnAddQuadroClick(Sender: TObject);
begin
  inherited;

  if (not btnAddQuadro.Visible) then
    Exit;
end;

procedure TfrmCfgQuadroAcompanhamentoOS.btnConfirmaClick(Sender: TObject);
const
  strSQL = 'INSERT INTO QDRAOS (QDR_QUADRO, QDR_TIPSTA, QDR_STATUS, QDR_CODEMP, QDR_QTDIAS) ' +
           'VALUES (:QUADRO, :TIPSTA, :STATUS, :CODEMP, :QTDIAS)';
var
  qryAux: TUniQuery;
begin
  if fMensagem('', 'Deseja salvar as alterações realizadas?', ['&Sim', '&Não']) = 2 then
  begin
    ModalResult := mrNone;
    Exit;
  end;

  inherited;

  qryAux := fCriaQuery;

  try
    fStartTransaction;

    try
      qryAux.SQL.Text := 'DELETE FROM QDRAOS WHERE QDR_CODEMP = :CODEMP ';
      qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryAux.ExecSQL;

      qryAux.SQL.Clear;
      qryAux.SQL.Text := strSQL;

      cdsGrid.First;

      while not cdsGrid.Eof do
      begin
        qryAux.Close;
        qryAux.ParamByName('QUADRO').AsInteger := cdsGrid.FieldByName('QUADRO').AsInteger;
        qryAux.ParamByName('TIPSTA').AsString  := cdsGrid.FieldByName('TIPSTA').AsString;
        qryAux.ParamByName('STATUS').AsString  := cdsGrid.FieldByName('STATUS').AsString;
        qryAux.ParamByName('CODEMP').AsString  := VS_strCodEmp;
        qryAux.ParamByName('QTDIAS').AsInteger := cdsGrid.FieldByName('QTDIAS').AsInteger;
        qryAux.ExecSQL;

        cdsGrid.Next;
      end;

      fCommit;
    except
      on E: Exception do
      begin
        fRollback;
        pMensagensErro(E.Message, '[btnConfirmaClick]');
      end;
    end;
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TfrmCfgQuadroAcompanhamentoOS.btnDelQuadroClick(Sender: TObject);
begin
  inherited;

  if (not btnDelQuadro.Visible) then
    Exit;
end;

procedure TfrmCfgQuadroAcompanhamentoOS.btnSairClick(Sender: TObject);
begin
  if fMensagem('', 'Deseja cancelar as configurações realizadas?', ['&Sim', '&Não']) = 2 then
  begin
    ModalResult := mrNone;
    Exit;
  end;

  inherited;
end;

procedure TfrmCfgQuadroAcompanhamentoOS.cdsGridNovoRegistro(DataSet: TDataSet);
begin
  cdsGrid.FieldByName('QTDIAS').AsInteger := 9999;
end;

procedure TfrmCfgQuadroAcompanhamentoOS.cxGridDBTBVBTNADDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  LTipSit: String;
  frmSelStatusAcompanhamentoOS: TfrmSelStatusAcompanhamentoOS;
begin
  inherited;

  pCriarFormularios(TfrmSelStatusAcompanhamentoOS, frmSelStatusAcompanhamentoOS);

  try
    frmSelStatusAcompanhamentoOS.ShowModal;

    if (frmSelStatusAcompanhamentoOS.ModalResult = mrOK) then
    begin
      cdsGrid.Edit;
      cdsGrid.FieldByName('STATUS').AsString := fRetornaSiglaSituacaoOS(frmSelStatusAcompanhamentoOS.strSituacao, LTipSit);
      cdsGrid.FieldByName('DESCRI').AsString := AnsiUpperCase(frmSelStatusAcompanhamentoOS.strSituacao);
      cdsGrid.FieldByName('TIPSTA').AsString := LTipSit;
      cdsGrid.Post;
    end;
  finally
    pFreeAndNil(frmSelStatusAcompanhamentoOS);
  end;
end;

procedure TfrmCfgQuadroAcompanhamentoOS.cxGridDBTBVBTNLIMPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  
  if fMensagem('', 'Deseja limpar as configurações do quadro?', ['&Sim', '&Não']) = 2 then
    Exit;

  cdsGrid.Edit;
  cdsGrid.FieldByName('TIPSTA').AsString := '';
  cdsGrid.FieldByName('STATUS').AsString := '';
  cdsGrid.FieldByName('DESCRI').AsString := '';
  cdsGrid.FieldByName('QTDIAS').AsString := '9999';
  cdsGrid.Post;
end;

procedure TfrmCfgQuadroAcompanhamentoOS.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSet;
  pCarregaDataSet;
end;

procedure TfrmCfgQuadroAcompanhamentoOS.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsGrid);
end;

procedure TfrmCfgQuadroAcompanhamentoOS.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_DELETE: btnDelQuadro.Click;
    VK_F2 : btnAddQuadro.Click;
  end;
end;

procedure TfrmCfgQuadroAcompanhamentoOS.pCarregaDataSet;
var
  qryQuadros: TUniQuery;
begin
  qryQuadros := fCriaQuery;

  try
    qryQuadros.SQL.Text := 'SELECT * FROM QDRAOS WHERE QDR_CODEMP = :CODEMP ';
    qryQuadros.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryQuadros.Open;

    while not qryQuadros.Eof do
    begin
      cdsGrid.Append;
      cdsGrid.FieldByName('QUADRO').AsInteger := qryQuadros.FieldByName('QDR_QUADRO').AsInteger;
      cdsGrid.FieldByName('TIPSTA').AsString  := qryQuadros.FieldByName('QDR_TIPSTA').AsString;
      cdsGrid.FieldByName('STATUS').AsString  := qryQuadros.FieldByName('QDR_STATUS').AsString;
      cdsGrid.FieldByName('DESCRI').AsString  := fRetornaDescricaoSituacaoOS(qryQuadros.FieldByName('QDR_STATUS').AsString, qryQuadros.FieldByName('QDR_TIPSTA').AsString);
      if qryQuadros.FieldByName('QDR_QTDIAS').IsNull then
        cdsGrid.FieldByName('QTDIAS').AsInteger := 9999
      else
        cdsGrid.FieldByName('QTDIAS').AsInteger := qryQuadros.FieldByName('QDR_QTDIAS').AsInteger;
      cdsGrid.Post;

      qryQuadros.Next;
    end;
  finally
    FreeAndNil(qryQuadros);
  end;
end;

procedure TfrmCfgQuadroAcompanhamentoOS.pCriaDataSet;
begin
  cdsGrid := TUniClientDataSet.Create(Self);
  cdsGrid.OnNewRecord := cdsGridNovoRegistro;
  cdsGrid.FieldDefs.Add('QUADRO', ftString, 15);
  cdsGrid.FieldDefs.Add('TIPSTA', ftString, 1);
  cdsGrid.FieldDefs.Add('STATUS', ftString, 2);
  cdsGrid.FieldDefs.Add('DESCRI', ftString, 30);
  cdsGrid.FieldDefs.Add('BTNADD', ftString, 1);
  cdsGrid.FieldDefs.Add('BTNLIM', ftString, 1);
  cdsGrid.FieldDefs.Add('QTDIAS', ftInteger);
  cdsGrid.CreateDataSet;

  dtsGrid.DataSet := cdsGrid;
end;

end.
