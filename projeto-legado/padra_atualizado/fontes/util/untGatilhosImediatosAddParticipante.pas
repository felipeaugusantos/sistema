unit untGatilhosImediatosAddParticipante;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass, untTypesSistema,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, UniClientDataSet, EditFocus;

type
  TTipoParticipante = (tipOperador, tipGrupo);

  TArrParticipantes = record
    arrParticipantes: TConsultasArray;
    tipParticipantes: TTipoParticipante;
  end;

  TfrmGatilhosImediatosAddParticipante = class(TfrmPaiConfirma)
    Label4: TLabel;
    edtGruGpo: TEditFocus;
    edtDesGpo: TEditFocus;
    Label2: TLabel;
    edtCodOpe: TEditFocus;
    edtDesOperador: TEditFocus;
    Label148: TLabel;
    edtDesEmpresa: TEditFocus;
    edtCodEmpresa: TEditFocus;
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure edtGruGpoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    arrOperador : TConsultasArray;
    arrGrupo : TConsultasArray;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; Override;
  public
    { Public declarations }
    cdsParticipantes: TUniClientDataSet;
    strGatCodigo: String;

    paticipantesSelecionados: TArrParticipantes;
  end;

implementation

{$R *.dfm}

uses untConsultas, untFuncoesSimples;

procedure TfrmGatilhosImediatosAddParticipante.btnConfirmaClick(
  Sender: TObject);
begin
  inherited;

  try
    if not fVerificaCampos then
    begin
      ModalResult := mrNone;
      Exit;
    end;

    if (fEmptyStr(edtDesOperador.Text)) and (fEmptyStr(edtDesGpo.Text)) then
    begin
      ModalResult := mrNone;
      fMensagem('Aviso', 'Informe pelo menos um operador ou um grupo de operadores!', ['&Ok']);
      Exit;
    end;

    if (Length(arrOperador) = 0) and (not fEmptyStr(edtCodOpe.Text)) then
    begin
      SetLength(arrOperador, 1);
      arrOperador[0].strCodigo := edtCodOpe.Text;
    end
    else if (Length(arrGrupo) = 0) and (not fEmptyStr(edtGruGpo.Text)) then
    begin
      SetLength(arrGrupo, 1);
      arrGrupo[0].strCodigo := edtGruGpo.Text;
    end;

    if Length(arrOperador) > 0 then
    begin
      paticipantesSelecionados.arrParticipantes := arrOperador;
      paticipantesSelecionados.tipParticipantes := tipOperador;
    end
    else
    begin
      paticipantesSelecionados.arrParticipantes := arrGrupo;
      paticipantesSelecionados.tipParticipantes := tipGrupo;
    end;

  finally
    if ModalResult = mrNone then
    begin
      if not fEmptyStr(edtCodOpe.Text) then
        pSetFocus(edtCodOpe)
      else if not fEmptyStr(edtGruGpo.Text) then
        pSetFocus(edtGruGpo)
      else
        pSetFocus(edtCodOpe);
    end;
  end;
end;

procedure TfrmGatilhosImediatosAddParticipante.edtCodEmpresaExit(
  Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodEmpresa.Text) Then
    edtDesEmpresa.Text := 'TODAS';
end;

procedure TfrmGatilhosImediatosAddParticipante.edtCodEmpresaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrEmp: TConsultasArray;
begin
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp, True, True) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGatilhosImediatosAddParticipante.edtCodOpeKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  SetLength(arrOperador, 0);
  if fPesqOperador(Self, edtCodOpe, edtDesOperador, nil, Key, arrOperador, False) then
  Begin
    If fValidaCampos(edtCodOpe, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmGatilhosImediatosAddParticipante.edtGruGpoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  SetLength(arrGrupo, 0);
  If fPesqGrupoOperador(Self, edtGruGpo, edtDesGpo, Nil, Key, arrGrupo, False) Then
  Begin
    If fValidaCampos(edtGruGpo, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmGatilhosImediatosAddParticipante.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  try
    If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Begin
      if Sender = edtCodOpe then
      begin
        edtDesOperador.Text := EmptyStr;
        if (Length(arrOperador) > 0) or (not fEmptyStr(edtCodOpe.Text)) then
        begin
          edtDesOperador.Text := IIF(Length(arrOperador) > 1, 'MULTI SELEÇÃO', fRetNomeOperador(edtCodOpe.Text));
          if fEmptyStr(edtDesOperador.Text) then
          begin
            fMensagem('Aviso', 'Operador inválido!', ['&Ok']);
            Exit(False);
          end;

          SetLength(arrGrupo, 0);
          edtDesGpo.Text := EmptyStr;
          edtGruGpo.Text := EmptyStr;
        end;
      end;

      if Sender = edtGruGpo then
      begin
        edtDesGpo.Text := EmptyStr;
        if (Length(arrGrupo) > 0) or (not fEmptyStr(edtGruGpo.Text)) then
        begin
          edtDesGpo.Text := IIF(Length(arrGrupo) > 1, 'MULTI SELEÇÃO', fRetNomCadGpo(edtGruGpo.Text));
          if fEmptyStr(edtDesGpo.Text) then
          begin
            fMensagem('Aviso', 'Grupo de Operador inválido!', ['&Ok']);
            Exit(False);
          end;

          SetLength(arrOperador, 0);
          edtCodOpe.Text := EmptyStr;
          edtDesOperador.Text := EmptyStr;
        end;
      end;

      if Sender = edtCodEmpresa then
      begin
        edtDesEmpresa.Text := EmptyStr;
        if not fEmptyStr(edtCodEmpresa.Text) then
        begin
          edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmpresa.Text);
          if fEmptyStr(edtDesEmpresa.Text) then
          begin
            fMensagem('Aviso', 'Empresa inválida!', ['&Ok']);
            Exit(False);
          end;
        end;
      end;
    End;

  finally
    If Not Result Then
      pSetFocus(Sender);
  end;

end;

end.
