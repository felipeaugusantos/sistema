unit untPnlBotoesAcoesNovaConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Uni,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, untTypesSistema,
  UniClientDataSet, untFuncoesSimples, strUtils, Vcl.ExtCtrls, untIConsulta, untIConsultaCompTintaNovaConfigurador,
  untIDataSet, untUniQueryDataSetWrapper, untIConsultaComp, Data.DB, untIDicionario;

type

  TfrmPnlBotoesAcoesNovaConsulta = class(TForm, IConsultaCompTintaNovaConfigurador)
    btnExecutaTarefa: TBitBtnLocked;
    btnExecutaTarefa2: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnExecutaTarefa2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FstrTabPre: string;
    procedure pVerificaAcesso(Sender: TObject);


    { Private declarations }
  public
    qryConsulta: TUniClientDataSet;
    cdsConsulta: TUniClientDataSet;
    strTabPre: string;
    Tinta : IConsulta;
    TipoConsulta: TTipoConsultaTinta;
    strIdePro: string;
    consultaComp: IConsultaComp;
    dicRetorno: IDicionario;
    constructor Create(tipoConsulta: TTipoConsultaTinta; strTabPre: String; tinta: IConsulta = nil; consultaComp: IConsultaComp = nil; dicRetorno: IDicionario = Nil); reintroduce;
    procedure pTarefaFormulacao(Sender: TObject); virtual; Abstract;
    procedure pTarefaPrecos(Sender: TObject); virtual; Abstract;
    procedure pTarefaVenda(Sender: TObject); virtual; Abstract;
    function GetDataSetConsulta: IDataSet;


    { Public declarations }
  end;
  TfrmPnlBotoesAcoesNovaConsultaClass = class of TfrmPnlBotoesAcoesNovaConsulta;



var
  frmPnlBotoesAcoesNovaConsulta: TfrmPnlBotoesAcoesNovaConsulta;

implementation

{$R *.dfm}

{ TForm1 }

procedure TfrmPnlBotoesAcoesNovaConsulta.btnExecutaTarefa2Click(Sender: TObject);
begin
{}
end;

constructor TfrmPnlBotoesAcoesNovaConsulta.Create(tipoConsulta: TTipoConsultaTinta; strTabPre: String; tinta: IConsulta; consultaComp: IConsultaComp; dicRetorno: IDicionario);
begin
 Inherited Create(Nil);
  Self.TipoConsulta := tipoConsulta;
  FstrTabPre := strTabPre;
  Self.Tinta := tinta;
  Self.consultaComp := consultacomp;
  Self.dicRetorno := dicRetorno;
end;

procedure TfrmPnlBotoesAcoesNovaConsulta.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If cdsConsulta.isEmpty Then
    Exit;
  case key of
    VK_F4 : Begin
              btnExecutaTarefa.Click;
              Key := 0;
            End;
    VK_F6 : Begin
              btnExecutaTarefa2.Click;
              Key := 0;
            End;
  end;
end;

procedure TfrmPnlBotoesAcoesNovaConsulta.FormShow(Sender: TObject);
begin
  qryConsulta:= cdsConsulta;

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

function TfrmPnlBotoesAcoesNovaConsulta.GetDataSetConsulta: IDataSet;
begin
  Result := TUniQueryDataSetWrapper.Create(qryConsulta);
end;

procedure TfrmPnlBotoesAcoesNovaConsulta.pVerificaAcesso(Sender: TObject);
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


end.
