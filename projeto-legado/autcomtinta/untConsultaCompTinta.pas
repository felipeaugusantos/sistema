unit untConsultaCompTinta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, DB,  
  Uni, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGridCitel, DBGrids,
  BitBtnLockedIncrem, MemDS, DBAccess, untPnlBotoesAcoesNovaConsulta;

type
  //TTipoConsulta = (tpcVenda, tpcGeral);

  TfrmConsultaCompTinta = class(TfrmConsultaComp)
    btnExecutaTarefa2: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FstrTabPre: String;
    procedure SetstrTabPre(const Value: String);
    function GetstrTabPre: String;
    { Private declarations }
  protected
    procedure pDesabilitaColunas;
    procedure pVerificaAcesso(Sender: TObject);
  public
    constructor Create(AOwner: TComponent; tipoConsulta: TTipoConsulta; strTabPre: String); reintroduce; virtual;
    procedure pTarefaVenda(Sender: TObject); virtual; abstract;
    procedure pTarefaPrecos(Sender: TObject); virtual; abstract;
    procedure pTarefaFormulacao(Sender: TObject); virtual; abstract;

    property strTabPre: String read GetstrTabPre write SetstrTabPre;

    { Public declarations }
  end;

var
  frmConsultaCompTinta: TfrmConsultaCompTinta;




implementation

{$R *.dfm}

uses untFuncoesSimples;

{ TfrmConsultaCompTinta }

procedure TfrmConsultaCompTinta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F6) And btnExecutaTarefa.Visible Then
  Begin
    btnExecutaTarefa2.Click;
  End
end;

constructor TfrmConsultaCompTinta.Create(AOwner: TComponent; tipoConsulta: TTipoConsulta; strTabPre: String);
begin
  Inherited Create(AOwner);

  case tipoConsulta of

    tpcVenda: Begin
      btnExecutaTarefa.Visible := True;
      btnExecutaTarefa.OnClick := pVerificaAcesso;
      btnExecutaTarefa.Caption := '[ F4 ] Cadastrar Nova Fórmula';

      If fVerificaAcessoSistema('COPRTI', strLoginUsuarioLogado) Then
      Begin
        btnExecutaTarefa2.Visible := True;
        btnExecutaTarefa2.OnClick := pTarefaPrecos;
        btnExecutaTarefa2.Caption := '[ F6 ] Ver Preço';
      End;
    End;

    tpcGeral: Begin
      If fVerificaAcessoSistema('COPRTI', strLoginUsuarioLogado) Then
      Begin
        btnExecutaTarefa.Visible := True;
        btnExecutaTarefa.OnClick := pTarefaFormulacao;
        btnExecutaTarefa.Caption := '[ F4 ] Formulação';
      End;

      btnExecutaTarefa2.Visible := False;
    End;

  end;

  Self.strTabPre := strTabPre;
end;

procedure TfrmConsultaCompTinta.pVerificaAcesso(Sender: TObject);
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

procedure TfrmConsultaCompTinta.SetstrTabPre(const Value: String);
begin
  FstrTabPre := IntToStr(StrToIntDef(Value, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD'))));
end;

function TfrmConsultaCompTinta.GetstrTabPre: String;
begin
  If (StrToIntDef(FstrTabPre, -1) = -1) Then
    Result := IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD'))
  Else
    Result := FstrTabPre;
end;

procedure TfrmConsultaCompTinta.pDesabilitaColunas;
begin
  qryConsulta.FieldByName('AUTOINCREM').Visible := False;
end;

end.
