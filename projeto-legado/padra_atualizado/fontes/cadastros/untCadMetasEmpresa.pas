unit untCadMetasEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untCadMetasEmpresaFrame;

type
  TfrmCadMetasEmpresa = class(TfrmPai)
    pnlFundo: TPanel;
    btnGravar: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    fraCadMetasEmpresa: TfraCadMetasEmpresaFrame;
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure pHabilitaDesabilitaBotoes(blnAlteracao: Boolean);
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  untTypesSistema, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadMetasEmpresa.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaDesabilitaBotoes(True);
  fraCadMetasEmpresa.btnCalMet.Click;
  pSetFocus(fraCadMetasEmpresa.cxGridMetas);
end;

procedure TfrmCadMetasEmpresa.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pHabilitaDesabilitaBotoes(False);
  pSetFocus(btnAlterar);
end;

procedure TfrmCadMetasEmpresa.btnGravarClick(Sender: TObject);
begin
  inherited;
  fraCadMetasEmpresa.pGravarMetas;
  btnCancela.Click;
end;

procedure TfrmCadMetasEmpresa.FormCreate(Sender: TObject);
begin
  inherited;
  fraCadMetasEmpresa.pOnFormCreate;
  fraCadMetasEmpresa.pnlEmpresa.Visible := True;
  fraCadMetasEmpresa.edtCodEmp.Text := VS_strCodEmp;
  fraCadMetasEmpresa.edtNomEmp.Text := fRetNomeEmpresaSelec(VS_strCodEmp);
end;

procedure TfrmCadMetasEmpresa.FormDestroy(Sender: TObject);
begin
  inherited;
  fraCadMetasEmpresa.pFormDestroy;
end;

procedure TfrmCadMetasEmpresa.FormShow(Sender: TObject);
begin
  inherited;
  fraCadMetasEmpresa.pFormShow;
end;

procedure TfrmCadMetasEmpresa.pHabilitaDesabilitaBotoes(blnAlteracao: Boolean);
begin
  btnGravar.Enabled := blnAlteracao;
  btnCancela.Enabled := blnAlteracao;
  btnAlterar.Enabled := Not blnAlteracao;
  fraCadMetasEmpresa.pHabilitaDesabilitaComponentesEdicao(blnAlteracao);
  fraCadMetasEmpresa.cxGridMetas.Enabled := blnAlteracao;
end;

end.
