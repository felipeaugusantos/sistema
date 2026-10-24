unit untEntImportaPedFornc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids, Mask,
  DirectoryEditFocus, DB, UniClientDataSet, AppEvnts, BitBtnLockedIncrem,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  Datasnap.DBClient, frxClass, frxExportCSVTestabilidade, cxButtons, 
  untFrameDirectoryEditFocus;

type
  TfrmEntImportaPedFornc = class(TfrmPai)
    pnlCabecalho: TPanel;
    dbgArquivos: TDBGridCitel;
    Label1: TLabel;
    dtsArqImp: TDataSource;
    cdsArqImp: TUniClientDataSet;
    cdsArqImpArquivo: TStringField;
    cdsArqImpMarcado: TStringField;
    OpenDialog1: TOpenDialog;
    btnConfirmaDados: TBitBtnLocked;
    btnAdicionar: TBitBtnLocked;
    fraPatTxt: TfraDirectoryEditFocus;
    btnHlpImp: TBitBtnLocked;
    frxHelp: TfrxReport;
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgArquivosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure dbgArquivosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgArquivosDblClick(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
  private
    procedure pSelecionaArquivo;
    { Private declarations }
  public
    { Public declarations }
    stlArquivos: TStringList;
    intQtdSel: Integer;
  end;

var
  frmEntImportaPedFornc: TfrmEntImportaPedFornc;

implementation

uses untfuncoesSimples;

{$R *.dfm}

procedure TfrmEntImportaPedFornc.btnAdicionarClick(Sender: TObject);
  Var
    srcArquivos: TSearchRec;
begin
  inherited;
  cdsArqImp.EmptyDataSet;
//  If (FindFirst(fraPatTxt.edtDirectory.text + '\*.txt', faArchive, srcArquivos) = 0) Then
  If (FindFirst(fraPatTxt.edtDirectory.text + '\*.txt', faAnyFile, srcArquivos) = 0) Then
  Begin
    Repeat

      cdsArqImp.Append;
      cdsArqImp.FieldByName('Arquivo').AsString := ExtractFileName(srcArquivos.Name);
      cdsArqImp.FieldByName('Marcado').AsString := 'D';
      cdsArqImp.Post;

    Until (FindNext(srcArquivos) <> 0);

    FindClose(srcArquivos);
    pSetFocus(dbgArquivos);
  End
  Else
    pSetFocus(fraPatTxt);
end;

procedure TfrmEntImportaPedFornc.FormCreate(Sender: TObject);
begin
  inherited;
  intQtdSel := 0;
  cdsArqImp.CreateDataSet;
end;

procedure TfrmEntImportaPedFornc.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  cdsArqImp.Close;
end;

procedure TfrmEntImportaPedFornc.dbgArquivosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    pSelecionaArquivo;
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    btnSair.Click;
  End
  Else If (Key = VK_F10) Then
  Begin
    btnConfirmaDados.Click;
  End;
end;

procedure TfrmEntImportaPedFornc.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (intQtdSel <= 0) Then
  Begin
    fMensagem('', 'É necessaário selecionar pelo menos um arquivo!', ['&Ok']);
    Exit;
  End;


  stlArquivos := TStringList.Create;
  cdsArqImp.First;
  cdsArqImp.DisableControls;

  While (Not cdsArqImp.Eof) Do
  Begin
    If (cdsArqImp.FieldByName('Marcado').AsString = 'M') Then
      stlArquivos.Add(fraPatTxt.edtDirectory.text + '\' + cdsArqImp.FieldByName('Arquivo').AsString);

    cdsArqImp.Next;
  End;

  Close;
  ModalResult := mrOk;

end;

procedure TfrmEntImportaPedFornc.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  frxHelp.DotMatrixReport := False;
  frxHelp.PrintOptions.PrintMode := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

procedure TfrmEntImportaPedFornc.dbgArquivosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  If (Not cdsArqImp.Active) Then
    Exit;

  If (cdsArqImp.FieldByName('Marcado').AsString = 'M') Then
    dbgArquivos.Canvas.Font.Color := clBlue;

  dbgArquivos.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmEntImportaPedFornc.pSelecionaArquivo;
begin
  cdsArqImp.Edit;
  If (cdsArqImp.FieldByName('Marcado').AsString = 'M') Then
  Begin
    cdsArqImp.FieldByName('Marcado').AsString := 'D';
    Dec(intQtdSel);
  End
  Else
  Begin

    If (intQtdSel = 1) Then
    Begin
      cdsArqImp.Cancel;
      fMensagem('', 'Só é permitido selecionar um arquivo!', ['&Ok']);
      Exit;
    End;

    cdsArqImp.FieldByName('Marcado').AsString := 'M';
    Inc(intQtdSel);
  End;
  cdsArqImp.Post;
end;

procedure TfrmEntImportaPedFornc.dbgArquivosDblClick(Sender: TObject);
begin
  inherited;
  pSelecionaArquivo;
end;

end.

