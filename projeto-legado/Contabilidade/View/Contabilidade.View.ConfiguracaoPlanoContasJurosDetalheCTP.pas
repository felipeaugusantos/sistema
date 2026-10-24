unit Contabilidade.View.ConfiguracaoPlanoContasJurosDetalheCTP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Data.DB, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, MemDS, DBAccess, Uni, Vcl.Mask, MaskEditFocus,
  Contabilidade.Interfaces;

type
  TfrmConfiguracaoPlanoContasJurosDetalheCTP = class(TfrmPaiContabilidade)
    Panel1: TPanel;
    Label1: TLabel;
    btnInserir: TBitBtnLocked;
    edtDesCta: TEditFocus;
    dbgPlanoContas: TDBGridCitel;
    ds: TDataSource;
    edtCodCta: TMaskEditFocus;
    rgConsiderar: TRadioGroup;
    procedure edtCodCtaExit(Sender: TObject);
    procedure edtCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure btnInserirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgPlanoContasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FqryCtaJdt: TUniQuery;
    FpcccTipo: TTipoPlanoContasCtpDetContabil ;
    procedure pCarregaPlanoContas;
    function fPlanoContasCadastrado(const AstrCodCta: String): Boolean;
    function fInserePlanoContas(const AstrCodCta, AstrTpCdPg: String): Boolean;
    function fRemoverPlanoContas(AstrCodCta: String): Boolean;
    { Private declarations }
  public
    { Public declarations }
    property Tipo: TTipoPlanoContasCtpDetContabil read FpcccTipo write FpcccTipo ;
  end;

implementation

uses untFuncoesSimples, Contabilidade.Consultas, untTypesSistema ;

{$R *.dfm}

procedure TfrmConfiguracaoPlanoContasJurosDetalheCTP.btnInserirClick(
  Sender: TObject);
begin
  inherited;
  If fEmptyStr(fTiraCaracEspeciais(edtCodCta.Text)) Then
  Begin
    fMensagem('ATENÇÃO!','Favor informar um conta para a inserção!',['&OK']);
    pSetFocus(edtCodCta);
    Exit;
  End;

  If fEmptyStr(edtDesCta.Text) Then
  Begin
    fMensagem('ATENÇÃO!','Conta não encontrado!',['&OK']);
    pSetFocus(edtCodCta);
    Exit;
  End;

  If (fPlanoContasCadastrado(fTiraCaracEspeciais(edtCodCta.Text))) Then
  Begin
    fMensagem('ATENÇÃO!','Esse plano contas já está cadastrado!',['&OK']);
    pSetFocus(edtCodCta);
    Exit;
  End;

  If fInserePlanoContas(fTiraCaracEspeciais(edtCodCta.Text), iif(rgConsiderar.ItemIndex = 0, CONTA_DO_CADASTRO, CONTA_DA_BAIXA)) Then
  Begin
    edtCodCta.Clear;
    edtDesCta.Clear;
    pSetFocus(edtCodCta);
    pCarregaPlanoContas;
  End
  Else
    fMensagem('ATENÇÃO!','Falha na gravação do plano de contas!',['&OK']);

end;

procedure TfrmConfiguracaoPlanoContasJurosDetalheCTP.dbgPlanoContasKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) And (Not FqryCtaJdt.IsEmpty) Then
  Begin
    If (fMensagem('ATENÇÃO!', Format('Deseja realmente excluir o plano de contas "%s"?', [FqryCtaJdt.FieldByName('CTA_DESCTA').AsString]), ['&Sim','&Não'], 2) = 1) Then
    Begin
      fRemoverPlanoContas(FqryCtaJdt.FieldByName('JDT_CODCTA').AsString);
      pCarregaPlanoContas;
    End;
  End;
end;

procedure TfrmConfiguracaoPlanoContasJurosDetalheCTP.edtCodCtaExit(
  Sender: TObject);
begin
  inherited;
  edtDesCta.Text := fRetDescCentroCusto(fTiraCaracEspeciais(edtCodCta.Text));
end;

procedure TfrmConfiguracaoPlanoContasJurosDetalheCTP.edtCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrConta : TConsultasArray;
begin
  If fPesqCentroCustoContabil(Self, edtCodCta, edtDesCta, Nil, Key, arrConta, True) Then
    pSetFocus(btnInserir);
end;

function TfrmConfiguracaoPlanoContasJurosDetalheCTP.fInserePlanoContas(
  const AstrCodCta, AstrTpCdPg: String): Boolean;
Var
  LqryTab : TUniQuery;
begin
  LqryTab := fCriaQuery(Self);
  Try
    LqryTab.Close;
    LqryTab.SQL.Clear;
    LqryTab.SQL.Add(' SELECT * ');
    LqryTab.SQL.Add('   FROM CTAJDT ');
    LqryTab.SQL.Add('  WHERE FALSE ');
    LqryTab.Open;

    LqryTab.Insert;
    LqryTab.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CTAJDT', VS_strCodEmp);
    LqryTab.FieldByName('JDT_CODCTA').AsString := AstrCodCta;
    LqryTab.FieldByName('JDT_TPCDPG').AsString := AstrTpCdPg;
    LqryTab.FieldByName('JDT_CODEMP').AsString := VS_strCodEmp;
    LqryTab.FieldByName('JDT_TIPREG').AsString := COD_TIPOPLANOCONTASCTPDET[FpcccTipo] ;
    LqryTab.Post;

    LqryTab.Close;

    Result := True;
  Finally
    FreeAndNil(LqryTab);
  End;
end;

procedure TfrmConfiguracaoPlanoContasJurosDetalheCTP.FormCreate(
  Sender: TObject);
begin
  inherited;
  FpcccTipo := pcccJuros ;
  FqryCtaJdt := fCriaQuery() ;
end;

procedure TfrmConfiguracaoPlanoContasJurosDetalheCTP.FormDestroy(
  Sender: TObject);
begin
  inherited;
  FreeAndNil(FqryCtaJdt) ;
end;

procedure TfrmConfiguracaoPlanoContasJurosDetalheCTP.FormShow(Sender: TObject);
begin
  inherited;
  ds.DataSet := FqryCtaJdt;
  pCarregaPlanoContas;
end;

function TfrmConfiguracaoPlanoContasJurosDetalheCTP.fPlanoContasCadastrado(
  const AstrCodCta: String): Boolean;
Var
  LqryTab : TUniQuery;
begin
  LqryTab := fCriaQuery(Self);
  Try
    LqryTab.Close;
    LqryTab.SQL.Clear;
    LqryTab.SQL.Add('SELECT ');
    LqryTab.SQL.Add('  COUNT(*) CNT ');
    LqryTab.SQL.Add('FROM ');
    LqryTab.SQL.Add('  CTAJDT ');
    LqryTab.SQL.Add('WHERE ');
    LqryTab.SQL.Add('  JDT_CODCTA = :CODCTA ');
    LqryTab.SQL.Add('  AND JDT_CODEMP = :CODEMP AND JDT_TIPREG = :TIPREG ');
    LqryTab.ParamByName('CODCTA').AsString := AstrCodCta;
    LqryTab.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LqryTab.ParamByName('TIPREG').AsString := COD_TIPOPLANOCONTASCTPDET[FpcccTipo] ;
    LqryTab.Open;
    Result := (LqryTab.FieldByName('CNT').AsInteger > 0);
    LqryTab.Close;
  Finally
    FreeAndNil(LqryTab);
  End;
end;

function TfrmConfiguracaoPlanoContasJurosDetalheCTP.fRemoverPlanoContas(
  AstrCodCta: String): Boolean;
Var
  LqryTab : TUniQuery;
begin
  LqryTab := fCriaQuery(Self);
  Try
    LqryTab.Close;
    LqryTab.SQL.Clear;
    LqryTab.SQL.Add('DELETE FROM CTAJDT ');
    LqryTab.SQL.Add('WHERE ');
    LqryTab.SQL.Add('  JDT_CODCTA = :CODCTA ');
    LqryTab.SQL.Add('  AND JDT_CODEMP = :CODEMP AND JDT_TIPREG = :TIPREG ');
    LqryTab.ParamByName('CODCTA').AsString := AstrCodCta;
    LqryTab.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LqryTab.ParamByName('TIPREG').AsString := COD_TIPOPLANOCONTASCTPDET[FpcccTipo] ;
    LqryTab.ExecSQL;
    Result := True;
  Finally
    FreeAndNil(LqryTab);
  End;
end;

procedure TfrmConfiguracaoPlanoContasJurosDetalheCTP.pCarregaPlanoContas;
begin
  FqryCtaJdt.Close;
  FqryCtaJdt.SQL.Clear;
  FqryCtaJdt.SQL.Add(' SELECT ');
  FqryCtaJdt.SQL.Add('   JDT_CODCTA, CTA_DESCTA, JDT_TPCDPG ');
  FqryCtaJdt.SQL.Add(' FROM ');
  FqryCtaJdt.SQL.Add('   CTAJDT ');
  FqryCtaJdt.SQL.Add('   JOIN CADCTA ON CTA_CODCTA = JDT_CODCTA ');
  FqryCtaJdt.SQL.Add(' WHERE ');
  FqryCtaJdt.SQL.Add('   JDT_CODEMP = :CODEMP AND JDT_TIPREG = :TIPREG ');
  FqryCtaJdt.SQL.Add(' ORDER BY ');
  FqryCtaJdt.SQL.Add('   CTA_DESCTA ');
  FqryCtaJdt.ParamByName('TIPREG').AsString := COD_TIPOPLANOCONTASCTPDET[FpcccTipo] ;
  FqryCtaJdt.ParamByName('CODEMP').AsString := VS_strCodEmp;
  FqryCtaJdt.Open;
end;

end.
