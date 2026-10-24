unit untExportaSpedFiscalInventario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, StdCtrls, Buttons, ExtCtrls, Uni, frxClass,
  frxExportCSVTestabilidade, Vcl.Menus, BitBtnLockedIncrem;

type
  TfrmExportaSpedFiscalInventario = class(TfrmPai)
    btnConfirma: TBitBtn;
    lsbTabelas: TListBox;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    FCarregaLote: boolean;
    function fTabela: String;
  end;

var
  frmExportaSpedFiscalInventario: TfrmExportaSpedFiscalInventario;

implementation

uses
  untFuncoes;

{$R *.dfm}

procedure TfrmExportaSpedFiscalInventario.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If lsbTabelas.ItemIndex >= 0 Then
  Begin
    ModalResult := mrOk;
  End
  Else
  Begin
    fMensagem('', 'É necessário escolher pelo menos uma tabela.', ['&Ok']);
  End;
end;

function TfrmExportaSpedFiscalInventario.fTabela: String;
begin
  Result := lsbTabelas.Items[lsbTabelas.ItemIndex];
end;

procedure TfrmExportaSpedFiscalInventario.FormShow(Sender: TObject);
  Var
    qryAux: TUniQuery;
begin
  inherited;
  try
    qryAux := fCriaQuery(Self);

    if FCarregaLote then
      qryAux.SQL.Add('SHOW TABLES LIKE "L\_%"')
    else
      qryAux.SQL.Add('SHOW TABLES LIKE "I\_%"');

    qryAux.Open;

    while (not qryAux.Eof) do
    begin
      lsbTabelas.Items.Add(qryAux.Fields[0].AsString);
      qryAux.Next;
    end;

    qryAux.SQL.Clear;
    qryAux.SQL.Add('SHOW TABLES LIKE "SALINV%"');
    qryAux.Open;

    while (not qryAux.Eof) do
    begin
      lsbTabelas.Items.Add(qryAux.Fields[0].AsString);
      qryAux.Next;
    end;
  finally
    FreeAndNil(qryAux);
  end;
end;

end.
