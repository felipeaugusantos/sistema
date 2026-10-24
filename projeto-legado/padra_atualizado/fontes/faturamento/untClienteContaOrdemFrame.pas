unit untClienteContaOrdemFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, EditFocus,
  Vcl.ExtCtrls, untFuncFat, untTypesSistema;

type
  TfraClienteContaOrdemFrame = class(TFrame)
    pnlFundo: TPanel;
    pnlClienteContaOrdem: TGroupBox;
    lblCliFor: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);

  private
    { Private declarations }
    blnIniciandoTela: Boolean;
    arrClientes: TConsultasArray;
    procedure pOnShow;
    function fVerificaSubObjeto(objObjeto: TWinControl): Boolean;

  public
    { Public declarations }
    objVenda: TFatVenda;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
    function fConfirmaDados: Boolean;
    function fVerificaCampos : Boolean;
    procedure OnFormCreate;
    procedure OnFormDestroy;
    procedure OnFormShow;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untFuncoesConsulta;

procedure TfraClienteContaOrdemFrame.edtCodCliExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodCli, edtNomCli, arrClientes, nil, fRetNomCliente, 'do cliente', 8);
end;

procedure TfraClienteContaOrdemFrame.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
Begin

  If fPesqCliente(conCliSimples, GetParentForm(self) as TForm, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(GetParentForm(self).ActiveControl, True, True);
  End;

end;

function TfraClienteContaOrdemFrame.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
Begin
  Result := True;

  If (Sender = edtCodCli) Then
  Begin
    If fEmptyStr(edtCodCli.Text) Then
    Begin
      fMensagem('ATENÇÃO!','O cliente deve ser informado!',['&Ok']);
      Result := False;
    End
    Else
    Begin
      edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
      If fEmptyStr(edtNomCli.Text) Then
      Begin
        fMensagem('', 'Cliente não encontrado !', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfraClienteContaOrdemFrame.fVerificaCampos: Boolean;
begin
  Result := fVerificaSubObjeto(Self);
end;

function TfraClienteContaOrdemFrame.fVerificaSubObjeto(objObjeto: TWinControl): Boolean;
  Var
    intContador: Integer;
Begin
  Result := True;

  For intContador := 0 To objObjeto.ComponentCount -1 Do
  Begin
    //Condição para evitar erro quando a função fVerificaCampos é chamada em algum form
    //e na função fValidaCampos deste form tem a destruição de um componente de tela.
    If intContador = objObjeto.ComponentCount Then
      Break;

    {**********************************}
    {* SE O COMPONETE FOR UM PANEL,   *}
    {* UM SCROLLBOX OU TABSHEET       *}
    {*******************************AF*}
    If (objObjeto.Components[intContador] Is TPanel)     Or
       (objObjeto.Components[intContador] Is TScrollBox) Or
       (objObjeto.Components[intContador] Is TGroupBox)  Or
       (objObjeto.Components[intContador] Is TFrame)      Then
    Begin

      If (objObjeto.Components[intContador] Is TPanel)    Then
      Begin
        {*******************************************}
        {* CASO NÃO QUERIA VALIDA UM TABSHEET, USE *}
        {* O VALOR -1 EM SEU TAG                   *}
        {****************************************MV*}
        If (objObjeto.Components[intContador].Tag = -1) Then
        Begin
          Exit
        End;
        //(objObjeto.Components[intContador] As TTabSheet).PageControl.ActivePage := (objObjeto.Components[intContador] As TTabSheet);
      End;

      Result := fVerificaSubObjeto((objObjeto.Components[intContador] As TWinControl));

      If Not Result Then
        Exit;

    End
    Else
    Begin
      {**************************************}
      {* SE A TAG DO COMPONENTES = 99 ENTÃO *}
      {***********************************AF*}
      If objObjeto.Components[intcontador].Tag = 99 Then
        If (objObjeto.Components[intContador] Is TWinControl) Then
        Begin
          Try
            Result := fValidaCampos((objObjeto.Components[intContador] As TWinControl), False);
          Except
            On E: Exception Do
            Begin
              pMensagensErro(E.Message,'[TfrmPai.fVerificaSubObjeto]');
              pGravarErro(True, E.Message + ' - ' + Self.Name + '.' + (objObjeto.Components[intContador] As TWinControl).Name);
              Result := False;
            End;
          End;
        End;

        If Not Result Then
          Exit;
    End;

  End;

end;

procedure TfraClienteContaOrdemFrame.OnFormCreate;
begin
  inherited;

end;

procedure TfraClienteContaOrdemFrame.OnFormDestroy;
begin
  inherited;
end;

procedure TfraClienteContaOrdemFrame.OnFormShow;
begin
  blnIniciandoTela := True;
  Try
    pOnShow;
  Finally
    blnIniciandoTela := False;
  End;
end;

procedure TfraClienteContaOrdemFrame.pOnShow;
begin
  If Not fEmptyStr(objVenda.strCliCEO) Then
  Begin
    edtCodCli.Text := objVenda.strCliCEO;
    fValidaCampos(edtCodCli);
  End;
end;

function TfraClienteContaOrdemFrame.fConfirmaDados: Boolean;
begin
  inherited;
  Result := fVerificaCampos;

  If Not Result Then
    Exit;

  objVenda.strCliCEO := edtCodCli.Text;

end;

end.
