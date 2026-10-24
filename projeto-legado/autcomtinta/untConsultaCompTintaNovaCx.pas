unit untConsultaCompTintaNovaCx;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  UniClientDataSet, BitBtnLockedIncrem, untPnlBotoesAcoesNovaConsulta,
  untTypesSistema;

type

  TfrmConsultaCompTintaNovaCx = class(TForm)
    btnExecutaTarefa: TBitBtnLocked;
    btnExecutaTarefa2: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FstrTabPre: String;
    procedure SetstrTabPre(const Value: String);
    function GetstrTabPre: String;
  protected
    procedure pVerificaAcesso(Sender: TObject);
  public
    { Public declarations }
    cdsConsulta: TUniClientDataSet;

    constructor Create(AOwner: TComponent; tipoConsulta: TTipoConsultaTinta; strTabPre: String); reintroduce; virtual;
    procedure pTarefaVenda(Sender: TObject); virtual; abstract;
    procedure pTarefaPrecos(Sender: TObject); virtual; abstract;
    procedure pTarefaFormulacao(Sender: TObject); virtual; abstract;

    property strTabPre: String read GetstrTabPre write SetstrTabPre;
  end;

  TfrmConsultaCompTintaNovaCxClass = Class Of TfrmConsultaCompTintaNovaCx;

var
  frmConsultaCompTintaNovaCx: TfrmConsultaCompTintaNovaCx;

implementation
uses untFuncoesSimples;
{$R *.dfm}

constructor TfrmConsultaCompTintaNovaCx.Create(AOwner: TComponent; tipoConsulta: TTipoConsultaTinta; strTabPre: String);
begin
  Inherited Create(AOwner);

  case tipoConsulta of

    tpcVenda: Begin
      btnExecutaTarefa.Visible := True;
      btnExecutaTarefa.OnClick := pVerificaAcesso;
      btnExecutaTarefa.Caption := '[ F4 ] Cadastrar Nova Fórmula';

      btnExecutaTarefa2.Visible := True;
      btnExecutaTarefa2.OnClick := pTarefaPrecos;
      btnExecutaTarefa2.Caption := '[ F6 ] Ver Preço';
    End;

    tpcGeral: Begin
      btnExecutaTarefa.Visible := True;
      btnExecutaTarefa.OnClick := pTarefaFormulacao;
      btnExecutaTarefa.Caption := '[ F4 ] Formulação';

      btnExecutaTarefa2.Visible := False;
    End;

  end;

  Self.strTabPre := strTabPre;
end;

procedure TfrmConsultaCompTintaNovaCx.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  Case Key Of
    VK_F4: If btnExecutaTarefa.Visible Then
             btnExecutaTarefa.Click;
    VK_F6: If btnExecutaTarefa2.Visible Then
             btnExecutaTarefa2.Click;
  End;

end;

procedure TfrmConsultaCompTintaNovaCx.pVerificaAcesso(Sender: TObject);
begin
  {*************************************}
  {* VERIFICA SE TEM DIREITO DE ACESSO *}
  {**********************************IV*}
  If Not fVerificaAcessoSistema('NOVFMT', strLoginUsuarioLogado) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!', ['&Ok']);
    Exit;
  End;

  pTarefaVenda(Sender);

end;

procedure TfrmConsultaCompTintaNovaCx.SetstrTabPre(const Value: String);
begin
  FstrTabPre := IntToStr(StrToIntDef(Value, 1));
end;

function TfrmConsultaCompTintaNovaCx.GetstrTabPre: String;
begin
  If (StrToIntDef(FstrTabPre, -1) = -1) Then
    Result := '1'
  Else
    Result := FstrTabPre;
end;

end.
