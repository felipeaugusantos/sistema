unit untCadDivAltComis;

interface

uses
  Windows, Classes, Controls, Forms, untPaiEdit, AppEvnts, Menus, StdCtrls,
  Buttons, EditFocus, untFuncoesSimples, Uni, BitBtnLockedIncrem, ExtCtrls,
  untTypesSistema;

type
  TfrmCadDivAltComis = class(TfrmPaiEdit)
    Label4: TLabel;
    edtCodAti: TEditFocus;
    edtNomAti: TEditFocus;
    edtPerCom: TEditFocus;
    Label18: TLabel;
    btnGravar: TBitBtnLocked;
    lblPerComPro: TLabel;
    Label1: TLabel;
    edtPerCop: TEditFocus;
    Label2: TLabel;
    procedure edtCodAtiExit(Sender: TObject);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    arrAtividade: TConsultasArray;

    Function fAlteraComissao: Boolean;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override;
  end;


implementation

uses  SysUtils, untConsultas, untFuncoesConsulta;

{$R *.dfm}

procedure TfrmCadDivAltComis.edtCodAtiExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodAti,edtNomAti,arrAtividade,nil,fRetNomAtividade,'da Atividade');

end;

procedure TfrmCadDivAltComis.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  If fPesqAtividade(Self, edtCodAti, edtNomAti, Nil, Key, arrAtividade, False) Then
	Begin
		fValidaCampos(edtCodAti, False);
		Self.SelectNext(ActiveControl, True, True);
	End;
end;

function TfrmCadDivAltComis.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtPerCom) Then
    Begin
      If (fStrToFloat(edtPerCom.Text) < 0) Or (fStrToFloat(edtPerCom.Text) > 100) Then
      Begin
        fMensagem('', 'O percetual deve estar entre 0 e 100%!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtPerCop) Then
    Begin
      If (fStrToFloat(edtPerCop.Text) < 0) Or (fStrToFloat(edtPerCop.Text) > 100) Then
      Begin
        fMensagem('', 'O percetual deve estar entre 0 e 100%!', ['&Ok']);
        Result := False;
      End;
    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

Function TfrmCadDivAltComis.fAlteraComissao: Boolean;
  var
    qryGen: TUniQuery;
    strAtivid: String;
Begin
  Try
    qryGen := fCriaQuery;

    With qryGen, SQL Do
    Begin
      Clear;
      Add('UPDATE CADDIV                ');
      Add('SET    DIV_PERCOM = :PERCOM, ');
      Add('       DIV_PERCOP = :PERCOP, ');
      Add('       DIV_DTAALT = :DTAALT, ');
      Add('       DIV_OPEALT = :OPEALT  ');
      Add('WHERE  TRUE                  ');
      Add(fStrLocate(edtCodAti, arrAtividade,  'DIV_CODATI', 'CODATI'));

      pSetaParam(edtCodAti.Text, arrAtividade, strAtivid, 'CODATI', qryGen);

      ParamByName('PERCOM').AsFloat := fStrToFloat(edtPerCom.Text);
      ParamByName('PERCOP').AsFloat := fStrToFloat(edtPerCop.Text);      
      ParamByName('DTAALT').AsDateTime := fRetDataServidor;
      ParamByName('OPEALT').AsString := strLoginUsuarioLogado;
      ExecSQL;
    End;

    FreeAndNil(qryGen);

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmCadDivAltComis.fAlteraComissao]');
    End;
  End;

End;

procedure TfrmCadDivAltComis.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin

    If fMensagem('', 'Confirma a alteração do Percentual de Comissão?', ['&Sim', '&Não']) = 1 Then
    Begin
      If fAlteraComissao Then
        fMensagem('', 'Comissão alterada com sucesso!', ['&Ok']);
    End

    Else
    Begin
      Action := caNone;
      Exit;
    End;  

  End;

end;

end.
