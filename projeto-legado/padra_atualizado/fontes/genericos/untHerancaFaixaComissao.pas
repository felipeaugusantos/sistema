unit untHerancaFaixaComissao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.StdCtrls, EditFocus, untConsultas,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Uni,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untTypesSistema, Data.DB;

type
  TfrmHerancaFaixaComissao = class(TfrmPai)
    Panel1: TPanel;
    Label9: TLabel;
    edtDescricao: TEditFocus;
    edtCodTab: TEditFocus;
    btnConfirma: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure edtCodTabKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    qryTabela: TUniQuery;
    blnConfirma: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmHerancaFaixaComissao: TfrmHerancaFaixaComissao;

implementation

{$R *.dfm}

uses untFuncoesSimples;

{ TfrmHerancaFaixaComissao }

procedure TfrmHerancaFaixaComissao.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Add('SELECT * FROM RECCOM WHERE COM_CODTAB = "' + edtCodTab.Text + '"');
  qryTabela.Open;

  If (qryTabela.Active) And (Not qryTabela.IsEmpty) Then
  Begin
    blnConfirma := True;
    Close;
  End
  Else
    fMensagem('ATENÇÃO','Defina uma Faixa de Comissão válida para realizar a herança!',['&O K']);
end;

procedure TfrmHerancaFaixaComissao.edtCodTabKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqRecComissaoVen(conSimples,
                         Self,
                         Nil,
                         Nil,
                         qryTabela,
                         Key,
                         arrSel) Then
  Begin
    If qryTabela.Active And (Not qryTabela.IsEmpty) Then
      edtCodTab.Text := qryTabela.FieldByName('COM_CODTAB').AsString;

    If fValidaCampos(edtCodTab, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmHerancaFaixaComissao.FormShow(Sender: TObject);
begin
  inherited;
  qryTabela := fCriaQuery;
  blnConfirma := False;
  edtCodTab.Clear;
  edtDescricao.Clear;
  pSetFocus(edtCodTab);
end;

function TfrmHerancaFaixaComissao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    if Sender = edtCodTab then
    begin
      If fEmptyStr(edtCodTab.Text) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Código da Faixa de Comissão deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      Begin
        edtDescricao.Text := fCampoTabela('COM_DESCRI', 'RECCOM', ['COM_CODTAB'], [edtCodTab.Text]);

        If fEmptyStr(edtDescricao.Text) Then
        Begin
          fMensagem('ATENÇÃO','Código da Faixa de Comissão não cadastrada!',['&O K']);
          Result := False;
        End;
      End;
    end;

    If Not Result Then
      pSetFocus(Sender);
  End;
end;

end.
