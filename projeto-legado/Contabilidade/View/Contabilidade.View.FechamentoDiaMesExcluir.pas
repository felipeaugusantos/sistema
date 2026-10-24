unit Contabilidade.View.FechamentoDiaMesExcluir;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Contabilidade.View.TfrmPaiConfirmaContabilidade, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, MaskEditFocus, EditFocus,
  untTypesSistema, Contabilidade.Classes.FechamentoDiaMes;

type
  TfrmExcluiFechamentoDiaMes = class(TfrmPaiConfirmaContabilidade)
    Label62: TLabel;
    Label1: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    mskUltFec: TMaskEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    ACodEmpresa: String;
    objFechamento: TFechamentoContabilDiaMes;
  end;

implementation

uses
  System.DateUtils, System.StrUtils,
  untConsultas, untFuncoesSimples;

{$R *.dfm}

{ TfrmExcluiFechamentoDiaMes }

procedure TfrmExcluiFechamentoDiaMes.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
var
  arrEmpresa : TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpresa) Then
  Begin
    If fValidaCampos(edtCodEmp, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmExcluiFechamentoDiaMes.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  LblnExcRaiz: Boolean;
begin
  inherited;
  If (ModalResult = mrOK) Then
  Begin

    If Not fVerificaCampos Then
    Begin
      Action := caNone;
      Exit;
    End;

    LblnExcRaiz := (objFechamento.fTemOutrosFechamentosNaRaiz(edtCodEmp.Text, StrToDateDef( mskUltFec.Text, 0))) and
      (fMensagem('ATENÇÃO', 'Deseja excluir o fechamento para as outras empresas na mesma raiz?', ['&Sim', '&Não']) = 1);

    try
      If objFechamento.fExcluirFechamento(edtCodEmp.Text, StrToDateDef( mskUltFec.Text, 0), LblnExcRaiz) Then
          fMensagem('', 'Fechamento(s) excluído(s) com sucesso!', ['&O k'])
      Else
        raise TFechamentoInclusaoException.Create('Erro ao excluir registro(s).');
    except
      on FE: TFechamentoException do
      begin
        fMensagem('ATENÇÃO', FE.Message, ['&O k']);
        Action := caNone;
      end;

      on E: Exception do
      begin
        pMensagensErro(E.Classname + ': ' + E.Message, 'TfrmExcluiFechamentoDiaMes.FormClose');
        Action := caNone;
      end;
    end;
  End;
end;

procedure TfrmExcluiFechamentoDiaMes.FormCreate(Sender: TObject);
begin
  inherited;
  objFechamento := nil;
  ACodEmpresa := '';
end;

procedure TfrmExcluiFechamentoDiaMes.FormShow(Sender: TObject);
begin
  inherited;
  edtCodEmp.Text := ACodEmpresa;

  If Not ACodEmpresa.IsEmpty Then
    fValidaCampos(edtCodEmp, True);

  if edtCodEmp.CanFocus then
    pSetFocus(edtCodEmp);
end;

function TfrmExcluiFechamentoDiaMes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  LData: TDate;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Informe a empresa para o fechamento!', ['&O k']);
      End Else
      Begin
        edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO!', 'Empresa não encontrada!', ['&O k']);
        End Else
        Begin
          LData := objFechamento.fGetDataUltimoFechamento(edtCodEmp.Text);

          If LData > 0 Then
          Begin
            mskUltFec.Text := FormatDateTime('DD/MM/YYYY', LData);
          End Else
          Begin
            mskUltFec.Clear;

            Result := False;
            fMensagem('ATENÇÃO!', 'Não há fechamentos para a empresa ' + edtCodEmp.Text + '!', ['&O k']);
          End;
        End
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.
