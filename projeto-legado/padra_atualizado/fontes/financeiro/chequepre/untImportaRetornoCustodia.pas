unit untImportaRetornoCustodia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, ComboBoxFocus, cxTextEdit, cxMaskEdit, cxButtonEdit,
  FilenameEditFocus, frxDBSet, TypInfo, System.Generics.Defaults,
  untTProcessaRetornoCustodia;

type
  TfrmImportaRetornoCustodia = class(TfrmPaiConfirma)
    edtArquivo: TFilenameEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    cbxBanco: TComboBoxFocus;
    frxRetCustodia: TfrxReport;
    frxCheques: TfrxUserDataSet;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure frxChequesFirst(Sender: TObject);
    procedure frxChequesNext(Sender: TObject);
    procedure frxChequesPrior(Sender: TObject);
    procedure frxChequesCheckEOF(Sender: TObject; var Eof: Boolean);
    procedure frxChequesNewGetValue(Sender: TObject; const VarName: string;
      var Value: Variant);
  private
    intIndex: Integer;
    objProcessador: TProcessaRetornoCustodia;
    function fImportaArquivo(strNomeArq, strCodBanco: String): Boolean;
    procedure pMostraRelatorio();
  public
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmImportaRetornoCustodia.btnConfirmaClick(Sender: TObject);
var
  strCodBanco: String;
begin
  If Not fVerificaCampos Then
    Exit;

  Case cbxBanco.ItemIndex Of
    0: strCodBanco := '033';
  End;

  if fImportaArquivo(edtArquivo.Text, strCodBanco) Then
    pMostraRelatorio;

  inherited;
end;

function TfrmImportaRetornoCustodia.fImportaArquivo(strNomeArq,
  strCodBanco: String): Boolean;
begin
  Result := objProcessador.fProcessaArquivo(strNomeArq, strCodBanco)
            And objProcessador.fProcessaArquivo('', 'DB');
end;

procedure TfrmImportaRetornoCustodia.FormCreate(Sender: TObject);
begin
  inherited;
  objProcessador := TProcessaRetornoCustodia.Create;
end;

procedure TfrmImportaRetornoCustodia.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objProcessador);
end;

procedure TfrmImportaRetornoCustodia.frxChequesCheckEOF(Sender: TObject;
  var Eof: Boolean);
begin
  inherited;
  Eof := (intIndex = objProcessador.lstCheques.Count);
end;

procedure TfrmImportaRetornoCustodia.frxChequesFirst(Sender: TObject);
begin
  inherited;
  intIndex := 0;
end;

procedure TfrmImportaRetornoCustodia.frxChequesNewGetValue(Sender: TObject;
  const VarName: string; var Value: Variant);
var
  objCheque: TChequeCustodia;
begin
  inherited;
  objCheque := objProcessador.lstCheques.Items[intIndex];
  Value := GetPropValue(objCheque, VarName);
end;

procedure TfrmImportaRetornoCustodia.frxChequesNext(Sender: TObject);
begin
  inherited;
  Inc(intIndex);
end;

procedure TfrmImportaRetornoCustodia.frxChequesPrior(Sender: TObject);
begin
  inherited;
  Dec(intIndex);
end;

function TfrmImportaRetornoCustodia.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If Sender = edtArquivo Then
    Begin
      If fEmptyStr(edtArquivo.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o nome do arquivo a ser processado.', ['&O k']);
        Result := False;
      End
      Else If Not FileExists(edtArquivo.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O arquivo informado não existe.', ['&O k']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmImportaRetornoCustodia.pMostraRelatorio;
begin
  objProcessador.lstCheques.Sort(TComparer<TChequeCustodia>.Construct(
    function (const obj1, obj2: TChequeCustodia): Integer
    Begin
      Result := TComparer<Integer>.Default.Compare(obj1.intStatus, obj2.intStatus);

      If Result = 0 Then
        Result := TComparer<String>.Default.Compare(obj1.strLote, obj2.strLote);

      If Result = 0 Then
        Result := TComparer<String>.Default.Compare(obj1.strCodOcorrencia, obj2.strCodOcorrencia);
    End
  ));

  frxRetCustodia.Script.Variables['NOMEMP'] := fRetNomeEmpresa;
  frxRetCustodia.Script.Variables['NOMARQ'] := edtArquivo.Text;
  pPreviewReport(Self.Name, Self.Caption, frxRetCustodia);
end;

end.
