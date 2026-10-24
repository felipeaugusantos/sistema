unit untConfImpressaoNFe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Math,

  {$IF Defined(UNIDAC)}
    UniClientDataSet, Uni, MySQLUniProvider, UniProvider, UITypes, IOUtils,
  {$ELSE}
   ZConnection, ZDataset, ZDbcIntfs,
  {$IFEND}
  Controls, Forms,
  ComCtrls, StdCtrls, ExtCtrls, DBCtrls, DB, MemDS,
  DBAccess, DBClient,
  Provider, Mask, DBEditFocus, EditFocus,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxDropDownEdit, cxButtonEdit,
  cxImage, cxCurrencyEdit, cxTextEdit, cxRadioGroup, cxBlobEdit, untConexaoBD,
  untImpressaoNFe, untImpressaoRG, untImpressaoNFS, XMLDoc,
  {$IFDEF VER300}
   cxDataControllerConditionalFormattingRulesManagerDialog,
  {$ENDIF}
  Menus, cxContainer, cxButtons, frxClass, cxImageComboBox, frxDBSet, xmldom, XMLIntf,
  cxDBData;

type
  TfrmConfImpressaoNFe = class(TForm)
    GridDB: TcxGridDBTableView;
    GridLevel1: TcxGridLevel;
    Grid: TcxGrid;
    GridDBNFE_CODEMP: TcxGridDBColumn;
    GridDBNFE_ORIENT: TcxGridDBColumn;
    GridDBNFE_POSREC: TcxGridDBColumn;
    GridDBNFE_VERSAO: TcxGridDBColumn;
    StatusBar1: TStatusBar;
    odXML: TOpenDialog;
    dsQuery: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    btnCarregarImagem: TcxButton;
    btnApagarImagem: TcxButton;
    odImg: TOpenDialog;
    btnImprimirDanfeTeste: TcxButton;
    PrintDialog1: TPrintDialog;
    GridDBNFE_MODELO: TcxGridDBColumn;
    btnLayout: TcxButton;
    btnResetLayout: TcxButton;
    btnImportarLayoutDANFeNFe: TcxButton;
    btnExportarLayoutDANFeNFe: TcxButton;
    odImpDANFe: TOpenDialog;
    sdExpDANFe: TSaveDialog;
    rdgLayNFe: TRadioGroup;
    btnImportarLayoutDANFeNFCeSAT: TcxButton;
    btnExportarLayoutDANFeNFCeSAT: TcxButton;
    pgcImagem: TPageControl;
    tbsLogo: TTabSheet;
    tbsMarcaDagua: TTabSheet;
    imgLogo: TcxImage;
    imgMarcaDagua: TcxImage;
    btnImportarLayoutDANFeNFeUnificado: TcxButton;
    btnExportarLayoutDANFeNFeUnificado: TcxButton;
    btnImportarLayoutDANFeNFeSimplificado: TcxButton;
    btnExportarLayoutDANFeNFeSimplificado: TcxButton;
    lblLogoSize: TLabel;
    lblMarcaDaguaSize: TLabel;
    tmrCarregarLayouts: TTimer;
    pgbProgresso: TProgressBar;
    pnlNFSePortalNacional: TPanel;
    tbsBrasao: TTabSheet;
    lblLogoBrasao: TLabel;
    imgBrasaoPrefeitura: TcxImage;
    dbePrefeitura: TDBEditFocus;
    lblPrefeitura: TLabel;
    lblSecretaria: TLabel;
    dbeSecretaria: TDBEditFocus;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCarregarImagemClick(Sender: TObject);
    procedure btnApagarImagemClick(Sender: TObject);
    procedure btnImprimirDanfeTesteClick(Sender: TObject);
    procedure GridDBKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dsQueryDataChange(Sender: TObject; Field: TField);
    procedure btnLayoutClick(Sender: TObject);
    procedure btnResetLayoutClick(Sender: TObject);
    procedure btnImportarLayoutDANFeNFeClick(Sender: TObject);
    procedure btnExportarLayoutDANFeNFeClick(Sender: TObject);
    procedure btnImportarLayoutDANFeNFCeSATClick(Sender: TObject);
    procedure btnExportarLayoutDANFeNFCeSATClick(Sender: TObject);
    procedure btnExportarLayoutDANFeNFeSimplificadoClick(Sender: TObject);
    procedure btnImportarLayoutDANFeNFeSimplificadoClick(Sender: TObject);
    procedure imgLogoClick(Sender: TObject);
    procedure imgMarcaDaguaClick(Sender: TObject);
    procedure lblLogoSizeClick(Sender: TObject);
    procedure lblMarcaDaguaSizeClick(Sender: TObject);
    procedure tmrCarregarLayoutsTimer(Sender: TObject);
    procedure lblLogoBrasaoClick(Sender: TObject);
    procedure btnImportarLayoutDANFeNFeUnificadoClick(Sender: TObject);
    procedure btnExportarLayoutDANFeNFeUnificadoClick(Sender: TObject);
  private
    { Private declarations }
    ImpressaoNFe : TImpressaoNFe;
    ConexaoBD : TConexaoBD;
    qryConf: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    procedure AfterScroll(DataSet: TDataSet);
    procedure pEditarLayout;
    procedure pImportarLayout(ALayoutSimplificado, ALayoutSmartPOS: Boolean;
                              ALayoutUnificado: Boolean = False);
    procedure pExportarLayout(ALayoutSimplificado, ALayoutSmartPOS: Boolean;
                              ALayoutUnificado: Boolean = False);
    procedure pCarregarImagem(const AFileName: String; AImage: TcxImage; ALabel: TLabel; tpImagem: TTipoImagem; blnAplicarTodasEmpresas: boolean = False);
    procedure pCarregarLayouts;
    function fExisteCamposPortalNacional: Boolean;
  public
    { Public declarations }
  end;

var
  frmConfImpressaoNFe: TfrmConfImpressaoNFe;

implementation

uses
  untModulo, untUtil, Printers, untImpressaoNFCe, untConfImpressora;

{$R *.dfm}

procedure TfrmConfImpressaoNFe.btnApagarImagemClick(Sender: TObject);
begin
  try
    If (pgcImagem.ActivePageIndex = 0) Then
    begin
      imgLogo.Picture.Graphic := nil;
      ConexaoBD.SalvarImagemBase64(qryConf.FieldByName('NFE_CODEMP').AsString, qryConf.FieldByName('NFE_VERSAO').AsFloat, imgLogo.Picture.Graphic, tpLogo, qryConf.FieldByName('NFE_MODELO').AsString);
    end
    else If (pgcImagem.ActivePageIndex = 1) Then
    begin
      imgMarcaDagua.Picture.Graphic := nil;
      ConexaoBD.SalvarImagemBase64(qryConf.FieldByName('NFE_CODEMP').AsString, qryConf.FieldByName('NFE_VERSAO').AsFloat, imgMarcaDagua.Picture.Graphic, tpMarcaDagua, qryConf.FieldByName('NFE_MODELO').AsString);
    end
    else If (pgcImagem.ActivePageIndex = 2) Then
    begin
      imgBrasaoPrefeitura.Picture.Graphic := nil;
      ConexaoBD.SalvarImagemBase64(qryConf.FieldByName('NFE_CODEMP').AsString, qryConf.FieldByName('NFE_VERSAO').AsFloat, imgBrasaoPrefeitura.Picture.Graphic, tpBrasaoPrefeitura, qryConf.FieldByName('NFE_MODELO').AsString);
    end;
  finally
    AfterScroll(qryConf);
  end;
end;

procedure TfrmConfImpressaoNFe.btnCarregarImagemClick(Sender: TObject);
var
  blnAplicarTodasEmpresas: boolean;
begin
  blnAplicarTodasEmpresas := false;
  if btnCarregarImagem.Enabled And odImg.Execute then
  begin
    if (pgcImagem.ActivePageIndex = 0) then
    begin
      if MessageDlg('Aplicar esse logotipo para todas as empresas?', mtConfirmation, mbYesNo, 0, mbNo) = mrYes then
        blnAplicarTodasEmpresas := true;
      pCarregarImagem(odImg.FileName, imgLogo, lblLogoSize, tpLogo, blnAplicarTodasEmpresas);
    end
    else if (pgcImagem.ActivePageIndex = 1) then
    begin
      pCarregarImagem(odImg.FileName, imgMarcaDagua, lblMarcaDaguaSize, tpMarcaDagua);
    end
    else
      pCarregarImagem(odImg.FileName, imgBrasaoPrefeitura, lblLogoBrasao, tpBrasaoPrefeitura);
  end;
end;

procedure TfrmConfImpressaoNFe.pCarregarImagem(const AFileName: String; AImage: TcxImage; ALabel: TLabel; tpImagem: TTipoImagem; blnAplicarTodasEmpresas: boolean = False);
var
  LSizeKB: Integer;
  LFileName: String;

  procedure AplicarResizeImage;
  begin
    {$IFDEF UNIDAC}
    LFileName:= TPath.GetTempFileName + '.bmp';
    {$ELSE}
    LFileName:= 'image.bmp';
    {$ENDIF}
    //ResizeImage(AImage.Picture.Bitmap, 500, KB, LFileName);
    ResizeImage(AImage.Picture.Bitmap, 150, LFileName);
    AImage.Picture.LoadFromFile(LFileName);
    LSizeKB := ImageSize(AImage.Picture.Bitmap, KB);
    ALabel.Caption := FloatToStr(LSizeKB) + ' KB';
  end;

begin
  try
    AImage.Picture.LoadFromFile(AFileName);
    LSizeKB := ImageSize(AImage.Picture.Bitmap, KB);
    ALabel.Caption := FloatToStr(LSizeKB) + ' KB';

    if LSizeKB > 500 then
    begin
      if MessageDlg('Arquivo de imagem ultrapassou o tamanho máximo permitido (500 KB). '+
        'Deseja comprimir a imagem para prosseguir?', mtConfirmation, mbYesNo, 0) = mrYes then
      begin
        AplicarResizeImage;
      end
      Else
      Begin
        Exit;
      End;
    end
    Else If (LSizeKB >= 300) Then
    Begin
      AplicarResizeImage;
    End;
    try
      Screen.Cursor := crHourGlass;
      ConexaoBD.SalvarImagemBase64(qryConf.FieldByName('NFE_CODEMP').AsString, qryConf.FieldByName('NFE_VERSAO').AsFloat, AImage.Picture.Graphic, tpImagem, qryConf.FieldByName('NFE_MODELO').AsString, blnAplicarTodasEmpresas);
    finally
      Screen.Cursor := crDefault;
    end;
  finally
    AfterScroll(qryConf);
  end;
end;

procedure TfrmConfImpressaoNFe.btnExportarLayoutDANFeNFCeSATClick(Sender: TObject);
begin
  pExportarLayout(False, False);
end;

procedure TfrmConfImpressaoNFe.btnExportarLayoutDANFeNFeClick(Sender: TObject);
begin
  pExportarLayout(False, False);
end;

procedure TfrmConfImpressaoNFe.btnExportarLayoutDANFeNFeSimplificadoClick(Sender: TObject);
begin
  pExportarLayout(True, False);
end;

procedure TfrmConfImpressaoNFe.btnImportarLayoutDANFeNFCeSATClick(Sender: TObject);
begin
  pImportarLayout(False, False);
end;

procedure TfrmConfImpressaoNFe.btnImportarLayoutDANFeNFeClick(Sender: TObject);
begin
  pImportarLayout(False, False);
end;

procedure TfrmConfImpressaoNFe.btnImportarLayoutDANFeNFeSimplificadoClick(Sender: TObject);
begin
  pImportarLayout(True, False);
end;

procedure TfrmConfImpressaoNFe.btnImprimirDanfeTesteClick(Sender: TObject);
var
  LChaveAcesso: string;
  LNomeImpressora: String;
begin
  If (qryConf.FieldByName('NFE_MODELO').AsString = 'NFE') Then
  Begin
    if (qryConf.State in [dsInsert, dsEdit]) then
      qryConf.Post();

    ConexaoBD.pSetaEmpresa(qryConf.FieldByName('NFE_CODEMP').AsString);

    LChaveAcesso := InputBox('Empresa: '+qryConf.FieldByName('NFE_CODEMP').AsString, 'Digite a chave de acesso da NFe: ', '');
    if not fEmptyStr(LChaveAcesso) then
    begin
      LNomeImpressora := EmptyStr;

      {$IFDEF UNIDAC}
      if fUtilizaSpoolImpressaoCitel(qryConf.FieldByName('NFE_CODEMP').AsString) then
        LNomeImpressora := fSelecionaPontoImpressao
      else
      {$ENDIF}
      if PrintDialog1.Execute() then
        LNomeImpressora := Printer.Printers[Printer.PrinterIndex];

      if not fEmptyStr(LNomeImpressora) then
        ImpressaoNFe.Imprimir(qryConf.FieldByName('NFE_CODEMP').AsString, LChaveAcesso, LNomeImpressora);
    end;
  End;
end;

procedure TfrmConfImpressaoNFe.btnLayoutClick(Sender: TObject);
begin
  If btnLayout.Enabled Then
    pEditarLayout;
end;

procedure TfrmConfImpressaoNFe.btnResetLayoutClick(Sender: TObject);
begin
  If btnResetLayout.Enabled Then
  Begin
    If MessageDlg('Esse processo vai substituir o layout existente.'+#13+
                  'Deseja continuar?',mtConfirmation,[mbYes,mbNo],0) = mrYes Then
    Begin
      qryConf.Edit;
      qryConf.FieldByName('NFE_LAYRET').AsString := qryConf.FieldByName('NFE_LAYPSG').AsString;
      qryConf.Post;
    End;
  End;
end;

procedure TfrmConfImpressaoNFe.dsQueryDataChange(Sender: TObject;
  Field: TField);
begin
  If Assigned(dsQuery.DataSet) Then
  Begin
    GridDBNFE_ORIENT.Options.Editing      := dsQuery.DataSet.FieldByName('NFE_MODELO').AsString = 'NFE';
    GridDBNFE_ORIENT.Options.Focusing     := dsQuery.DataSet.FieldByName('NFE_MODELO').AsString = 'NFE';
    GridDBNFE_POSREC.Options.Editing      := dsQuery.DataSet.FieldByName('NFE_MODELO').AsString = 'NFE';
    GridDBNFE_POSREC.Options.Focusing     := dsQuery.DataSet.FieldByName('NFE_MODELO').AsString = 'NFE';
    GridDBNFE_VERSAO.Options.Editing      := dsQuery.DataSet.FieldByName('NFE_MODELO').AsString = 'NFE';
    GridDBNFE_VERSAO.Options.Focusing     := dsQuery.DataSet.FieldByName('NFE_MODELO').AsString = 'NFE';
    btnLayout.Enabled                     := dsQuery.DataSet.FieldByName('NFE_MODELO').AsString <> 'NFE';
    btnResetLayout.Enabled                := dsQuery.DataSet.FieldByName('NFE_MODELO').AsString <> 'NFE';
    btnApagarImagem.Enabled               := (dsQuery.DataSet.FieldByName('NFE_MODELO').AsString = 'NFE') or
                                             (dsQuery.DataSet.FieldByName('NFE_MODELO').AsString = 'NFS') or
                                             (dsQuery.DataSet.FieldByName('NFE_MODELO').AsString = 'NFCE');
    btnCarregarImagem.Enabled             := (dsQuery.DataSet.FieldByName('NFE_MODELO').AsString = 'NFE') or
                                             (dsQuery.DataSet.FieldByName('NFE_MODELO').AsString = 'NFS') or
                                             (dsQuery.DataSet.FieldByName('NFE_MODELO').AsString = 'NFCE');
    btnImprimirDanfeTeste.Enabled         := dsQuery.DataSet.FieldByName('NFE_MODELO').AsString = 'NFE';
    btnImportarLayoutDANFeNFe.Enabled     := dsQuery.DataSet.FieldByName('NFE_MODELO').AsString = 'NFE';
    btnExportarLayoutDANFeNFe.Enabled     := dsQuery.DataSet.FieldByName('NFE_MODELO').AsString = 'NFE';
    btnImportarLayoutDANFeNFCeSAT.Enabled := dsQuery.DataSet.FieldByName('NFE_MODELO').AsString <> 'NFE';
    btnExportarLayoutDANFeNFCeSAT.Enabled := dsQuery.DataSet.FieldByName('NFE_MODELO').AsString <> 'NFE';
    btnImportarLayoutDANFeNFeSimplificado.Enabled := dsQuery.DataSet.FieldByName('NFE_MODELO').AsString = 'NFE';
    btnExportarLayoutDANFeNFeSimplificado.Enabled := dsQuery.DataSet.FieldByName('NFE_MODELO').AsString = 'NFE';
    btnImportarLayoutDANFeNFeUnificado.Enabled    := dsQuery.DataSet.FieldByName('NFE_MODELO').AsString = 'NFE';
    btnExportarLayoutDANFeNFeUnificado.Enabled    := dsQuery.DataSet.FieldByName('NFE_MODELO').AsString = 'NFE';
    pnlNFSePortalNacional.Visible := False;
    tbsBrasao.TabVisible := False;

    If (dsQuery.DataSet.FieldByName('NFE_MODELO').AsString = 'NFS') Then
    Begin
      rdgLayNFe.Enabled := False;
      btnImportarLayoutDANFeNFe.Enabled := False;
      btnExportarLayoutDANFeNFe.Enabled := False;
      btnResetLayout.Enabled := False;
      btnImprimirDanfeTeste.Enabled := False;
      btnLayout.Enabled := False;
      pnlNFSePortalNacional.Visible := fExisteCamposPortalNacional;
      tbsBrasao.TabVisible := fExisteCamposPortalNacional;
    End;

  End;
end;

procedure TfrmConfImpressaoNFe.AfterScroll(DataSet: TDataSet);
var
  LSize: Integer;
begin
  imgLogo.Picture.Graphic := nil;
  ConexaoBD.CarregarImagemBase64(DataSet.FieldByName('NFE_CODEMP').AsString, DataSet.FieldByName('NFE_VERSAO').AsFloat, imgLogo.Picture, tpLogo, DataSet.FieldByName('NFE_MODELO').AsString);
  LSize := ImageSize(imgLogo.Picture.Bitmap, KB);

  if LSize > 500 then
  begin
    lblLogoSize.Caption := FloatToStr(LSize) + ' KB' + IIF(btnCarregarImagem.Enabled, ' (clique aqui para redimensionar a imagem)', '');
    lblLogoSize.Font.Color := clRed;
    lblLogoSize.Font.Style := [fsUnderline];
  end
  else
  begin
    lblLogoSize.Caption := FloatToStr(LSize) + ' KB';
    lblLogoSize.Font.Color := clGreen;
    lblLogoSize.Font.Style := [];
  end;

  imgMarcaDagua.Picture.Graphic := nil;
  ConexaoBD.CarregarImagemBase64(DataSet.FieldByName('NFE_CODEMP').AsString, DataSet.FieldByName('NFE_VERSAO').AsFloat, imgMarcaDagua.Picture, tpMarcaDagua, DataSet.FieldByName('NFE_MODELO').AsString);
  LSize := ImageSize(imgMarcaDagua.Picture.Bitmap, KB);

  if LSize > 500 then
  begin
    lblMarcaDaguaSize.Caption := FloatToStr(LSize) + ' KB' + IIF(btnCarregarImagem.Enabled, ' (clique aqui para redimensionar a imagem)', '');
    lblMarcaDaguaSize.Font.Color := clRed;
    lblMarcaDaguaSize.Font.Style := [fsUnderline];
  end
  else
  begin
    lblMarcaDaguaSize.Caption := FloatToStr(LSize) + ' KB';
    lblMarcaDaguaSize.Font.Color := clGreen;
    lblMarcaDaguaSize.Font.Style := [];
  end;

  If fExisteCamposPortalNacional Then
  begin
    imgBrasaoPrefeitura.Picture.Graphic := nil;
    ConexaoBD.CarregarImagemBase64(DataSet.FieldByName('NFE_CODEMP').AsString, DataSet.FieldByName('NFE_VERSAO').AsFloat, imgBrasaoPrefeitura.Picture, tpBrasaoPrefeitura, DataSet.FieldByName('NFE_MODELO').AsString);
    LSize := ImageSize(imgBrasaoPrefeitura.Picture.Bitmap, KB);

    if LSize > 500 then
    begin
      lblLogoBrasao.Caption := FloatToStr(LSize) + ' KB' + IIF(btnCarregarImagem.Enabled, ' (clique aqui para redimensionar a imagem)', '');
      lblLogoBrasao.Font.Color := clRed;
      lblLogoBrasao.Font.Style := [fsUnderline];
    end
    else
    begin
      lblLogoBrasao.Caption := FloatToStr(LSize) + ' KB';
      lblLogoBrasao.Font.Color := clGreen;
      lblLogoBrasao.Font.Style := [];
    end;
  end;

end;

procedure TfrmConfImpressaoNFe.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if qryConf.State in [dsInsert, dsEdit] then
    qryConf.Post();
  FreeAndNil(qryConf);

  ConexaoBD.Free;
  ImpressaoNFe.Free();

  Action := caFree;
end;

procedure TfrmConfImpressaoNFe.pCarregarLayouts;
var
  qryEmp: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  tslSAT: TStringList;
  tslNFCe:TStringList;
  tslRG: TStringList;
  tslNFS: TStringList;
  tslNFE: TStringList;
  tslCCE: TStringList;
  tslMDFE: TStringList;
  tslCTE: TStringList;
  blnGerou: Boolean;
  strArquivos : String;

  procedure pCarregaDados;
  Begin
    qryConf.Close;
    qryConf.SQL.Clear;
    qryConf.SQL.Add('SELECT * FROM IMPNFE ORDER BY NFE_CODEMP, NFE_MODELO, NFE_VERSAO');
    qryConf.Open;
  End;

  procedure pAddLayout(strCodEmp, strModelo: String; intPosRec: integer = 1);
    Var
      strVerModelo: String;
  Begin

    strVerModelo := '';

    If (strModelo='NFCE') Then
      strVerModelo := tslNFCe.Text
    Else If (strModelo='SAT') Then
      strVerModelo := tslSAT.Text
    Else If (strModelo='RG') Then
      strVerModelo := tslRG.Text
    Else If (strModelo='NFS') Then
      strVerModelo := tslNFS.Text
    Else If (strModelo='NFE') Then
      strVerModelo := tslNFE.Text
    Else If (strModelo='CCE') Then
      strVerModelo := tslCCE.Text
    Else If (strModelo='MDFE') Then
      strVerModelo := tslMDFE.Text
    Else If (strModelo='CTE') Then
      strVerModelo := tslCTE.Text;

    qryConf.Insert;
    qryConf.FieldByName('NFE_CODEMP').AsString  := strCodEmp;
    qryConf.FieldByName('NFE_MODELO').AsString  := strModelo;
    qryConf.FieldByName('NFE_VERSAO').AsFloat   := 4.00;
    qryConf.FieldByName('NFE_ORIENT').AsInteger := 1;
    qryConf.FieldByName('NFE_POSREC').AsInteger := intPosRec;
    qryConf.FieldByName('NFE_LAYPSG').AsString  := strVerModelo;
    qryConf.FieldByName('NFE_LAYRET').AsString  := strVerModelo;
    qryConf.Post;
  End;

  procedure pAddArquivoNaoGerado(const AValue: String);
  begin
    If (fEmptyStr(strArquivos)) Then
      strArquivos := AValue
    Else
      strArquivos := strArquivos + ', ' + AValue;
  End;

begin
  blnGerou := True;

  ConexaoBD := TConexaoBD.Create(frmModulo.Database);

  qryConf := fCriaQuery(self);

  Try
    strArquivos := '';

    pCarregaDados;

    tslSAT  := TStringList.Create;
    tslNFCe := TStringList.Create;
    tslRG   := TStringList.Create;
    tslNFS  := TStringList.Create;
    tslNFE  := TStringList.Create;
    tslCCE  := TStringList.Create;
    tslMDFE := TStringList.Create;
    tslCTE  := TStringList.Create;

    qryEmp := fCriaQuery(self);
    qryEmp.SQL.Clear;
    qryEmp.SQL.Add('SELECT * FROM CADEMP ORDER BY EMP_CODEMP');
    qryEmp.Open;

    pgbProgresso.Max := qryEmp.RecordCount;

    If (FileExists('DanfeSat.fr3')) Then
    Begin
      tslSAT.LoadFromFile('DanfeSat.fr3');
      qryEmp.First;
      pgbProgresso.Position := 0;
      While not qryEmp.Eof Do
      Begin
        pgbProgresso.Position := qryEmp.RecNo;
        Application.ProcessMessages;
        If not qryConf.Locate('NFE_CODEMP;NFE_MODELO', VarArrayOf([qryEmp.FieldByName('EMP_CODEMP').AsString,'SAT']),[]) Then
          pAddLayout(qryEmp.FieldByName('EMP_CODEMP').AsString, 'SAT');
        qryEmp.Next;
      End;
    End
    Else
    Begin
      blnGerou := False;
      pAddArquivoNaoGerado('DanfeSat.fr3');
    End;

    If (FileExists('DanfeNFCe.fr3')) Then
    Begin
      tslNFCe.LoadFromFile('DanfeNFCe.fr3');
      qryEmp.First;
      pgbProgresso.Position := 0;
      While not qryEmp.Eof Do
      Begin
        pgbProgresso.Position := qryEmp.RecNo;
        Application.ProcessMessages;
        If not qryConf.Locate('NFE_CODEMP;NFE_MODELO', VarArrayOf([qryEmp.FieldByName('EMP_CODEMP').AsString,'NFCE']),[]) Then
          pAddLayout(qryEmp.FieldByName('EMP_CODEMP').AsString, 'NFCE');
        qryEmp.Next;
      End;
    End
    Else
    Begin
      blnGerou := False;
      pAddArquivoNaoGerado('DanfeNFCe.fr3');
    End;

    If (FileExists('DanfeRG.fr3')) Then
    Begin
      tslRG.LoadFromFile('DanfeRG.fr3');
      qryEmp.First;
      pgbProgresso.Position := 0;
      While not qryEmp.Eof Do
      Begin
        pgbProgresso.Position := qryEmp.RecNo;
        Application.ProcessMessages;
        If not qryConf.Locate('NFE_CODEMP;NFE_MODELO', VarArrayOf([qryEmp.FieldByName('EMP_CODEMP').AsString,'RG']),[]) Then
          pAddLayout(qryEmp.FieldByName('EMP_CODEMP').AsString, 'RG');
        qryEmp.Next;
      End;
    End
    Else
    Begin
      blnGerou := False;
      pAddArquivoNaoGerado('DanfeRG.fr3');
    End;

    If (FileExists('DanfeNFS.fr3')) Then
    Begin
      tslNFS.LoadFromFile('DanfeNFS.fr3');
      qryEmp.First;
      pgbProgresso.Position := 0;
      While not qryEmp.Eof Do
      Begin
        pgbProgresso.Position := qryEmp.RecNo;
        Application.ProcessMessages;
        If not qryConf.Locate('NFE_CODEMP;NFE_MODELO', VarArrayOf([qryEmp.FieldByName('EMP_CODEMP').AsString,'NFS']),[]) Then
          pAddLayout(qryEmp.FieldByName('EMP_CODEMP').AsString, 'NFS');
        qryEmp.Next;
      End;
    End
    Else
    Begin
      blnGerou := False;
      pAddArquivoNaoGerado('DanfeNFS.fr3');
    End;

    If (FileExists('DanfeNfeModeloFIT.fr3')) Then
    Begin
      tslNFE.LoadFromFile('DanfeNfeModeloFIT.fr3');
      qryEmp.First;
      pgbProgresso.Position := 0;
      While not qryEmp.Eof Do
      Begin
        pgbProgresso.Position := qryEmp.RecNo;
        Application.ProcessMessages;
        If not qryConf.Locate('NFE_CODEMP;NFE_MODELO', VarArrayOf([qryEmp.FieldByName('EMP_CODEMP').AsString,'NFE']),[]) Then
          pAddLayout(qryEmp.FieldByName('EMP_CODEMP').AsString, 'NFE', 0);
        qryEmp.Next;
      End;
    End
    Else
    Begin
      blnGerou := False;
      pAddArquivoNaoGerado('DanfeNfeModeloFIT.fr3');
    End;

    If (FileExists('DanfeCCe.fr3')) Then
    Begin
      tslCCe.LoadFromFile('DanfeCCe.fr3');
      qryEmp.First;
      pgbProgresso.Position := 0;
      While not qryEmp.Eof Do
      Begin
        pgbProgresso.Position := qryEmp.RecNo;
        Application.ProcessMessages;
        If not qryConf.Locate('NFE_CODEMP;NFE_MODELO', VarArrayOf([qryEmp.FieldByName('EMP_CODEMP').AsString,'CCE']),[]) Then
          pAddLayout(qryEmp.FieldByName('EMP_CODEMP').AsString, 'CCE');
        qryEmp.Next;
      End;
    End
    Else
    Begin
      blnGerou := False;
      pAddArquivoNaoGerado('DanfeCCe.fr3');
    End;

    If (FileExists('DanfeMDFe.fr3')) Then
    Begin
      tslMDFe.LoadFromFile('DanfeMDFe.fr3');
      qryEmp.First;
      pgbProgresso.Position := 0;
      While not qryEmp.Eof Do
      Begin
        pgbProgresso.Position := qryEmp.RecNo;
        Application.ProcessMessages;
        If not qryConf.Locate('NFE_CODEMP;NFE_MODELO', VarArrayOf([qryEmp.FieldByName('EMP_CODEMP').AsString,'MDFE']),[]) Then
          pAddLayout(qryEmp.FieldByName('EMP_CODEMP').AsString, 'MDFE');
        qryEmp.Next;
      End;
    End
    Else
    Begin
      blnGerou := False;
      pAddArquivoNaoGerado('DanfeMDFe.fr3');
    End;

    If (FileExists('DanfeCTe.fr3')) Then
    Begin
      tslCTE.LoadFromFile('DanfeCTe.fr3');
      qryEmp.First;
      pgbProgresso.Position := 0;
      While not qryEmp.Eof Do
      Begin
        pgbProgresso.Position := qryEmp.RecNo;
        Application.ProcessMessages;
        If not qryConf.Locate('NFE_CODEMP;NFE_MODELO', VarArrayOf([qryEmp.FieldByName('EMP_CODEMP').AsString,'CTE']),[]) Then
          pAddLayout(qryEmp.FieldByName('EMP_CODEMP').AsString, 'CTE');
        qryEmp.Next;
      End;
    End
    Else
    Begin
      blnGerou := False;
      pAddArquivoNaoGerado('DanfeCTe.fr3');
    End;

    If (not blnGerou) Then
    Begin
      MessageDlg(Format('Os arquivos (%s) não estão na pasta.' +#13+
                 'Não foi possível gerar os layouts padrão relacionado a esses arquivos.', [strArquivos]), mtError, [mbOk], 0);
    End;

  Finally
    FreeAndNil(qryEmp);
    FreeAndNil(tslSAT);
    FreeAndNil(tslNFCe);
    FreeAndNil(tslRG);
    FreeAndNil(tslNFS);
    FreeAndNil(tslNFE);
    FreeAndNil(tslCCe);
    FreeAndNil(tslMDFe);
    FreeAndNil(tslCTE);
  End;

  pCarregaDados;
  qryConf.First;

  dsQuery.DataSet := qryConf;

  if fExisteCamposPortalNacional then
  begin
    dbePrefeitura.DataSource := dsQuery;
    dbeSecretaria.DataSource := dsQuery;
  end;

  ImpressaoNFe := TImpressaoNFe.Create();

  qryConf.AfterScroll := Self.AfterScroll;
  AfterScroll(qryConf);

  If qryConf.FindField('NFE_MDAGUA') <> Nil Then
    tbsMarcaDagua.TabVisible := True
  else
    tbsMarcaDagua.TabVisible := False;

  pgcImagem.ActivePage := tbsLogo;
end;

procedure TfrmConfImpressaoNFe.FormDestroy(Sender: TObject);
begin
  frmConfImpressaoNFe := nil;
end;

procedure TfrmConfImpressaoNFe.GridDBKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F10 then
    btnLayout.Click;

  if Key = VK_F11 then
    btnResetLayout.Click;

  if Key = VK_F12 then
    btnImprimirDanfeTeste.Click;
end;

procedure TfrmConfImpressaoNFe.imgLogoClick(Sender: TObject);
begin
//  if odImg.Execute then
//    imgLogo.Picture.SaveToFile(odImg.FileName);
end;

procedure TfrmConfImpressaoNFe.imgMarcaDaguaClick(Sender: TObject);
begin
//  if odImg.Execute then
//    imgMarcaDagua.Picture.SaveToFile(odImg.FileName);
end;

procedure TfrmConfImpressaoNFe.lblLogoBrasaoClick(Sender: TObject);
var
  LFileName: String;
begin
  if btnCarregarImagem.Enabled And (Pos('redimensionar', lblLogoBrasao.Caption) > 0) then
  begin
    {$IFDEF UNIDAC}
    LFileName:= TPath.GetTempFileName + '.bmp';
    {$ELSE}
    LFileName:= 'image.bmp';
    {$ENDIF}
    ResizeImage(imgBrasaoPrefeitura.Picture.Bitmap, 500, KB, LFileName);
    pCarregarImagem(LFileName, imgBrasaoPrefeitura, lblLogoBrasao, tpBrasaoPrefeitura);
  end;
end;

procedure TfrmConfImpressaoNFe.lblLogoSizeClick(Sender: TObject);
var
  LFileName: String;
begin
  if btnCarregarImagem.Enabled And (Pos('redimensionar', lblLogoSize.Caption) > 0) then
  begin
    {$IFDEF UNIDAC}
    LFileName:= TPath.GetTempFileName + '.bmp';
    {$ELSE}
    LFileName:= 'image.bmp';
    {$ENDIF}
    ResizeImage(imgLogo.Picture.Bitmap, 500, KB, LFileName);
    pCarregarImagem(LFileName, imgLogo, lblLogoSize, tpLogo);
  end;
end;

procedure TfrmConfImpressaoNFe.lblMarcaDaguaSizeClick(Sender: TObject);
var
  LFileName: String;
begin
  if btnCarregarImagem.Enabled And (Pos('redimensionar', lblMarcaDaguaSize.Caption) > 0) then
  begin
    {$IFDEF UNIDAC}
    LFileName:= TPath.GetTempFileName + '.bmp';
    {$ELSE}
    LFileName:= 'image.bmp';
    {$ENDIF}
    ResizeImage(imgMarcaDagua.Picture.Bitmap, 500, KB, LFileName);
    pCarregarImagem(LFileName, imgMarcaDagua, lblMarcaDaguaSize, tpMarcaDagua);
  end;
end;

procedure TfrmConfImpressaoNFe.pEditarLayout;
var
  DanfeRG : TImpressaoRG;
  DanfeNFCe : TImpressaoNFCe;
  DanfeNFS: TImpressaoNFS;
begin
  If (qryConf.FieldByName('NFE_MODELO').AsString='NFS') Then
  Begin
    DanfeNFS := TImpressaoNFS.Create();
    try
      DanfeNFS.dtsConf := TDataSource.Create(nil);
      DanfeNFS.dtsConf.DataSet := qryConf;

      DanfeNFS.Imprimir(qryConf.FieldByName('NFE_CODEMP').AsString, 'NS', '', '', True);

    finally
      DanfeNFS.Free;
    end;
  End
  Else
  If (qryConf.FieldByName('NFE_MODELO').AsString='RG') Then
  Begin
    DanfeRG := TImpressaoRG.Create();
    try
      DanfeRG.dtsConf := TDataSource.Create(nil);
      DanfeRG.dtsConf.DataSet := qryConf;

      DanfeRG.Imprimir(qryConf.FieldByName('NFE_CODEMP').AsString, '', '', '', True);

    finally
      DanfeRG.Free;
    end;
  End
  Else
  Begin
    DanfeNFCe := TImpressaoNFCe.Create();
    try
      DanfeNFCe.dtsConf := TDataSource.Create(nil);
      DanfeNFCe.dtsConf.DataSet := qryConf;

      DanfeNFCe.Imprimir(qryConf.FieldByName('NFE_CODEMP').AsString,'', '', True,
                         qryConf.FieldByName('NFE_MODELO').AsString);

    finally
      DanfeNFCe.Free;
    end;
  End;
end;

procedure TfrmConfImpressaoNFe.pExportarLayout(ALayoutSimplificado, ALayoutSmartPOS: Boolean;
                                               ALayoutUnificado: Boolean = False);
begin
  if qryConf.IsEmpty then
    MessageDlg('Nenhum registro selecionado para exportar.', mtWarning, [mbOk], 0)
  else if Pos(qryConf.FieldByName('NFE_MODELO').AsString, 'NFE_NFCE_SAT_RG_NFS') = 0 then
    MessageDlg('O modelo ' + qryConf.FieldByName('NFE_MODELO').AsString + ' não é suportado por essa funcionalidade.', mtWarning, [mbOk], 0)
  else if sdExpDANFe.Execute then
  begin
    ConexaoBD.pExportarLayoutDANFe(qryConf.FieldByName('NFE_CODEMP').AsString,
                                   qryConf.FieldByName('NFE_MODELO').AsString,
                                   qryConf.FieldByName('NFE_VERSAO').AsFloat,
                                   rdgLayNFe.ItemIndex,
                                   sdExpDANFe.FileName,
                                   ALayoutSimplificado,
                                   ALayoutSmartPOS,
                                   ALayoutUnificado);
    MessageDlg('Layout exportado com sucesso.', mtInformation, [mbOk], 0);
  end;
end;

procedure TfrmConfImpressaoNFe.pImportarLayout(ALayoutSimplificado, ALayoutSmartPOS: Boolean;
                                               ALayoutUnificado: Boolean = False);
begin
  {$IF Defined(UNIDAC)}
  if qryConf.IsEmpty then
    MessageDlg('Nenhum registro selecionado para importar.', mtWarning, [mbOk], 0)
  else if Pos(qryConf.FieldByName('NFE_MODELO').AsString, 'NFE_NFCE_SAT_RG_NFS') = 0 then
    MessageDlg('O modelo ' + qryConf.FieldByName('NFE_MODELO').AsString + ' não é suportado por essa funcionalidade.', mtWarning, [mbOk], 0)
  else if odImpDANFe.Execute then
  begin
    ConexaoBD.pImportarLayoutDANFe(qryConf.FieldByName('NFE_CODEMP').AsString,
                                   qryConf.FieldByName('NFE_MODELO').AsString,
                                   qryConf.FieldByName('NFE_VERSAO').AsFloat,
                                   rdgLayNFe.ItemIndex,
                                   odImpDANFe.FileName,
                                   ALayoutSimplificado,
                                   ALayoutSmartPOS,
                                   ALayoutUnificado);
    MessageDlg('Layout importado com sucesso.', mtInformation, [mbOk], 0);
  end;
  {$ELSE}
    MessageDlg('Recurso indisponível nessa versão.', mtWarning, [mbOk], 0);
  {$IFEND}
end;

procedure TfrmConfImpressaoNFe.btnImportarLayoutDANFeNFeUnificadoClick(Sender: TObject);
begin
  pImportarLayout(False, False, True);
end;

procedure TfrmConfImpressaoNFe.btnExportarLayoutDANFeNFeUnificadoClick(Sender: TObject);
begin
  pExportarLayout(False, False, True);
end;

procedure TfrmConfImpressaoNFe.tmrCarregarLayoutsTimer(Sender: TObject);
begin
  tmrCarregarLayouts.Enabled := False;
  pgbProgresso.Visible := True;
  try
    Screen.Cursor := crHourGlass;
    try
      pCarregarLayouts;
    finally
      Screen.Cursor := crDefault;
    end;
  finally
    pgbProgresso.Visible := False;
  end;
end;

function TfrmConfImpressaoNFe.fExisteCamposPortalNacional: Boolean;
begin
  Result := ( (dsQuery.DataSet.FindField('NFE_BRASAO') <> Nil) and
              (dsQuery.DataSet.FindField('NFE_NOMPRE') <> Nil) and
              (dsQuery.DataSet.FindField('NFE_NOMSEC') <> Nil) );
end;

end.
