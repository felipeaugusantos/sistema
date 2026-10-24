unit untSelecionaPegPedItens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.StdCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untFuncFat, untConstantes, Data.DB;

type
  TfrmSelecionaPegPedItem = class(TfrmPaiConfirma)
    pnlPrincipal: TPanel;
    chkPegou: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    function fAlterarPegPedItens: Boolean;
    function fRetFiltroSelecao: String;
    function fItensParaPegPed: Boolean;

  public
    { Public declarations }
    strSelecao: String;
    objFatVenda: TFatVenda;

    intAutIncPosAlt: Integer;
    blnPegPed: String;
    strItens: string;
    arrSelecao: TArrayString;
    arrSelecaoAutoIncrem: TArrayString;
  end;

implementation

uses
  untFuncoesSimples, untSelFatDigTipoEntregaItens, untFatDigTipoEntregaItens;

{$R *.dfm}

procedure TfrmSelecionaPegPedItem.FormShow(Sender: TObject);
begin
  inherited;

  chkPegou.Caption := fObtemDescricaoCampoPegPed;
  chkPegou.Width := Length(chkPegou.Caption) * 10;
end;

function TfrmSelecionaPegPedItem.fItensParaPegPed: Boolean;
var
  frmSelFatDigTipoEntregaItens: TfrmSelFatDigTipoEntregaItens;
Begin
  Result := False;
  pCriarFormularios(TfrmSelFatDigTipoEntregaItens, frmSelFatDigTipoEntregaItens);
  Try
    Try
      frmSelFatDigTipoEntregaItens.fatVenda := Self.objFatVenda;
      frmSelFatDigTipoEntregaItens.Caption := 'Selecione os itens a serem modificados';
      If (frmSelFatDigTipoEntregaItens.ShowModal = mrOk) And frmSelFatDigTipoEntregaItens.blnSelecao Then
      Begin
        arrSelecaoAutoIncrem := frmSelFatDigTipoEntregaItens.arrSelecaoAutoIncrem;
        strSelecao := frmSelFatDigTipoEntregaItens.arrSelecao;

        Result := True;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;

  Finally
    pFreeAndNil(frmSelFatDigTipoEntregaItens);
  End;
End;

function TfrmSelecionaPegPedItem.fRetFiltroSelecao: String;
  var
    strSelecaoAux: String;
begin
  strSelecaoAux := '';

  If (Not fEmptyStr(strItens)) Then
    strSelecaoAux := IIF(Not fEmptyStr(strSelecao),',','') + strItens;


  Result := ' ITE_ORDITE IN (' + strSelecao + strSelecaoAux + ') ';
end;

procedure TfrmSelecionaPegPedItem.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If fItensParaPegPed Then
    fAlterarPegPedItens;

end;

function TfrmSelecionaPegPedItem.fAlterarPegPedItens: Boolean;
Var
  strFilter: String;
  blnFilter: Boolean;
  oleItens : OleVariant;
begin
  Result    := False;
  Try
    strFilter := cdsVenda.Filter;
    blnFilter := cdsVenda.Filtered;
    cdsVenda.Filtered  := False;
    oleItens  := cdsVenda.Data;

    If Not fEmptyStr(strSelecao) Then
    Begin
      cdsVenda.Filter := fRetFiltroSelecao;
      cdsVenda.Filtered := True;
    End;

    cdsVenda.First;
    While Not cdsVenda.Eof Do
    Begin
      cdsVenda.Edit;
      cdsVenda.FieldByName('ITE_PEGOU_').AsString := IIF(chkPegou.Checked, 'S', 'N');
      cdsVenda.FieldByName('ITE_VPEGOU').AsString := IIF(chkPegou.Checked, 'S', '');
      cdsVenda.Post;
      cdsVenda.Next;
    End;
    cdsVenda.First;

    Result := (Not cdsVenda.IsEmpty);

    If Not Result Then
      cdsVenda.Data := oleItens;

    cdsVenda.Filter   := strFilter;
    cdsVenda.Filtered := blnFilter;
    objFatVenda.pFormataDecimaisGrid;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fAlterarPegPedItens]');
    End;
  End;
end;

end.
