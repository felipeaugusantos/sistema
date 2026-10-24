unit untSelFilImpressao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.ComCtrls, Winapi.ShlObj, cxShellCommon,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxListView, cxShellListView,
  Printers, WinSpool, System.UITypes, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, Uni, strUtils,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxImageComboBox, cxTextEdit, cxGridLevel, cxGridCustomTableView,
  cxGridCardView, cxGridDBCardView, cxClasses, cxGridCustomView,
  cxGridCustomLayoutView, cxGrid, cxGridCitel, System.ImageList, Vcl.ImgList,
  cxImageList, Datasnap.DBClient, UniClientDataSet, untIDataset,
  untInterfacesIntegracaoPixCitel, untTelasAbertas;

type
  TfrmSelFilImpressao = class(TForm)
    cdsImpressoras: TUniClientDataSet;
    cdsImpressorasicone: TIntegerField;
    cdsImpressorasnome_impressora: TStringField;
    dtsImpressoras: TDataSource;
    imgImpressoras: TcxImageList;
    cxgImpressoras: TcxGridCitel;
    cxgImpressorasView: TcxGridDBCardView;
    cxgImpressorasViewicone: TcxGridDBCardViewRow;
    cxgImpressorasViewnome_impressora_exibir: TcxGridDBCardViewRow;
    cxgImpressorasLevel: TcxGridLevel;
    cdsImpressorasnome_impressora_exibir: TStringField;
    pnlBotoes: TPanel;
    lblNomPro: TLabel;
    FlwBotoes: TFlowPanel;
    btnSair: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgImpressorasViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxgImpressorasViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure cxgImpressorasEnter(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    function fGetPrinterIconIndex(Printer: String): Integer;
    procedure pCarregarImpressorasInstaladas;
    procedure pCarregarImpressorasCadastradas;
    function fGetImpPadraoWindows: String;
    { Private declarations }
  public
    { Public declarations }
    strImpSelecionada: String;
    strTipoImpSelecionada: String;
    blnImpressorasCadastradas: Boolean;
    strFrm: String;
    FilaImpressao: IDataset;
    FTelas : ITelasAbertas;

    procedure pEmpilharTelaAberta;
    procedure pRemoverTelaAberta;
    procedure CarregaFilaConfigurada;
  end;

var
  frmSelFilImpressao: TfrmSelFilImpressao;

Const
  IMP_MATRICIAL = 'Matricial';
  IMP_JATO_LASER = 'Jato de Tinta/Laser';

implementation
Uses untFuncoesSimples;
{$R *.dfm}

{ TfrmSelFilImpressao }

procedure TfrmSelFilImpressao.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If Not btnConfirma.Enabled Then
  Begin
    MessageDlg('Selecione uma Impressora!', mtInformation, [mbOK], 0);
    Exit;
  End;

  strImpSelecionada := cdsImpressorasnome_impressora.AsString;

  strTipoImpSelecionada := '';

  If Pos('('+ IMP_MATRICIAL + ')', cdsImpressorasnome_impressora_exibir.AsString) > 0 Then
    strTipoImpSelecionada := IMP_MATRICIAL;

  If Pos('('+ IMP_JATO_LASER + ')', cdsImpressorasnome_impressora_exibir.AsString) > 0 Then
    strTipoImpSelecionada := IMP_JATO_LASER;

  If strImpSelecionada.IsEmpty Then
  Begin
    MessageDlg('Selecione uma Impressora!', mtInformation, [mbOK], 0);
    Exit;
  End;

  Self.Close;
end;

procedure TfrmSelFilImpressao.btnSairClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmSelFilImpressao.CarregaFilaConfigurada;
begin
  If Not FilaImpressao.IsEmpty Then
  Begin
    strImpSelecionada := FilaImpressao.FieldByName('REL_NOMFIL').AsString;
    strTipoImpSelecionada := FilaImpressao.FieldByName('REL_IDEIMP').AsString;

    If FilaImpressao.FieldByName('REL_IMPPAD').AsString = 'S' Then
      strImpSelecionada := fGetImpPadraoWindows;
  End;
end;

procedure TfrmSelFilImpressao.cxgImpressorasEnter(Sender: TObject);
begin
  inherited;
  btnConfirma.Enabled := True;
end;

procedure TfrmSelFilImpressao.cxgImpressorasViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  btnConfirma.Click;
end;

procedure TfrmSelFilImpressao.cxgImpressorasViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: btnConfirma.Click;
  End;
end;

function TfrmSelFilImpressao.fGetPrinterIconIndex(Printer: String): Integer;
begin
  Result := 0;
  If UpperCase(Printer).Equals(UpperCase(fGetImpPadraoWindows)) Then
    Result := 1;
end;

procedure TfrmSelFilImpressao.pCarregarImpressorasCadastradas;
Var
  strNomeImpressora: String;
  strTipoImpressora: String;
  qryCadImp: IDataset;
begin
  inherited;
  cdsImpressoras.CreateDataSet;
  qryCadImp := VS_FuncoesExternas.fGetDataSet;
  Try
    qryCadImp.SQL := 'SELECT IMP_NOMIMP, IMP_TIPIMP FROM CADIMP ORDER BY 1, 2';
    qryCadImp.Open;

    While Not qryCadImp.Eof Do
    Begin
      strNomeImpressora := qryCadImp.FieldByName('IMP_NOMIMP').AsString;
      strTipoImpressora := qryCadImp.FieldByName('IMP_TIPIMP').AsString;
      strTipoImpressora := IfThen(strTipoImpressora = 'M', IMP_MATRICIAL, IMP_JATO_LASER);
      cdsImpressoras.AppendRecord([fGetPrinterIconIndex(strNomeImpressora),
        strNomeImpressora, strNomeImpressora + ' (' + strTipoImpressora + ')']);
      qryCadImp.Next;
    End;
    cdsImpressoras.First;
  Finally

  End;
end;

procedure TfrmSelFilImpressao.pCarregarImpressorasInstaladas;
Var
  strImpressora: String;
begin
  inherited;
  cdsImpressoras.CreateDataSet;
  Try
    For strImpressora In Printer.Printers Do
      cdsImpressoras.AppendRecord([fGetPrinterIconIndex(strImpressora), strImpressora, strImpressora]);
  Except
    //do nothing sometimes ocurr access violation
  End;
  cdsImpressoras.First;
end;

procedure TfrmSelFilImpressao.pEmpilharTelaAberta;
begin
  FTelas := untTelasAbertas.objTelasAbertas;

  If Assigned(FTelas) Then
    FTelas.AddFormAndSetPopupMode(Self);
end;

procedure TfrmSelFilImpressao.pRemoverTelaAberta;
begin
  If Assigned(FTelas) Then
    FTelas.RemoveFormParent(Self);
end;

procedure TfrmSelFilImpressao.FormCreate(Sender: TObject);
begin
  inherited;
  blnImpressorasCadastradas := False;
  strImpSelecionada     := '';
  strTipoImpSelecionada := '';
  pEmpilharTelaAberta;
end;

procedure TfrmSelFilImpressao.FormDestroy(Sender: TObject);
begin
  pRemoverTelaAberta;
end;

procedure TfrmSelFilImpressao.FormShow(Sender: TObject);
begin
  inherited;

  If (fCfgSis('CADIMP', VS_FuncoesExternas.fGetEmpresaLogada) = 'S') And blnImpressorasCadastradas Then
    pCarregarImpressorasCadastradas
  Else
    pCarregarImpressorasInstaladas;

  lblNomPro.Caption := strFrm;

  //Posicionar na impressora padrao
  cdsImpressoras.Locate('icone', 1, []);
  //Remover o foco do grid
  pSetFocus(btnConfirma, Self);
  //Desabilitar o botao, deve selecionar um registro no grid para habilitar novamente
  btnConfirma.Enabled := False;
end;

function TfrmSelFilImpressao.fGetImpPadraoWindows: String;
Var
  Device: Array [0 .. 255] Of char;
  Driver: Array [0 .. 255] Of char;
  Port: Array [0 .. 255] Of char;
  Handle: THandle;
begin
  Printer.PrinterIndex := -1;
  Printer.GetPrinter(Device, Driver, Port, Handle);
  Result := Device;
end;

end.
