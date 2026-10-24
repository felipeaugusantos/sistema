unit untAdicionaArquivo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.DBCtrls, DBLookupComboBoxFocus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxButtonEdit, FilenameEditFocus, untArquivamento,
  Data.DB, untPaiConfirma;

type
  TfrmAdicionaArquivo = class(TfrmPai)
    dbeCategoria: TDBLookupComboBoxFocus;
    Label1: TLabel;
    Label2: TLabel;
    edtArquivo: TFilenameEditFocus;
    btnConfirmar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private
    objArquivamento : TArquivamento;
    dtsCatArq       : TDataSource;
    { Private declarations }
  public

  protected
    function fValidaCampos(Sender : TWinControl; blnBuscarPorChave : Boolean): Boolean; Override;
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmAdicionaArquivo.btnConfirmarClick(Sender: TObject);
begin
  if fVerificaCampos then
  begin
    objArquivamento.strFile   := edtArquivo.Text;
    objArquivamento.strcodCat := dbeCategoria.KeyValue;
    if objArquivamento.fImportaArquivo then
    begin
      pMensagemOk('Arquivo importado com sucesso');
      dbeCategoria.KeyValue := '';
      edtArquivo.Clear;
      pSetFocus(dbeCategoria);
    end;
  end;
end;

procedure TfrmAdicionaArquivo.FormCreate(Sender: TObject);
begin
  inherited;
  objArquivamento := TArquivamento.Create(Self);
  objArquivamento.pOpenCatArq;

  dtsCatArq := TDataSource.Create(Self);
  dtsCatArq.DataSet := objArquivamento.qryCatArq;

  dbeCategoria.Listsource := dtsCatArq;
  dbeCategoria.KeyField   := 'AUTINC';
  dbeCategoria.ListField  := 'DESCRI';
end;

function TfrmAdicionaArquivo.fValidaCampos(Sender: TWinControl;
  blnBuscarPorChave: Boolean): Boolean;
var
  strAutInc : String;
begin
  Result := True;

  If (Sender = dbeCategoria) Then
  Begin
    If (dbeCategoria.KeyValue = null) or (dbeCategoria.KeyValue = '' ) or (not blnBuscarPorChave and (dbeCategoria.KeyValue = '0')) Then
    Begin
      Result := False;
      pMensagemOK('Selecione uma categoria!');
    End
    else begin
      if blnBuscarPorChave then
      begin
        if dbeCategoria.KeyValue = '0' then
        begin
          Self.Hide;
          strAutInc := objArquivamento.fNovaCategoria;
          Self.Show;
          if not fEmptyStr(strAutInc) then
            dbeCategoria.KeyValue := strAutInc;
        end;
      end;
    end;
  End

  else If (Sender = edtArquivo) Then
  Begin
    If fEmptyStr(edtArquivo.Text) Then
    Begin
      Result := False;
      pMensagemOK('Selecione o arquivo!');
    End
    else If not FileExists(edtArquivo.Text) Then
    Begin
      Result := False;
      pMensagemOK('Arquivo não localizado!');
    End;
  End;

  if not Result then
    pSetfocus(Sender);
end;

end.
