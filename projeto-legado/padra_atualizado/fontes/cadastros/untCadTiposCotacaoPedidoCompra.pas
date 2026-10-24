unit untCadTiposCotacaoPedidoCompra;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls, DBEditFocus, Data.DB, Uni, untTypesSistema;

type
  TfrmCadTiposCotacaoPedidoCompra = class(TfrmPaiCad)
    pnlCentral: TPanel;
    lbl2: TLabel;
    lbl3: TLabel;
    dbeDesTct: TDBEditFocus;
    dbeCodTct: TDBEditFocus;
    dtsCadTct: TDataSource;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    qryCadTct: TUniQuery;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadTiposCotacaoPedidoCompra: TfrmCadTiposCotacaoPedidoCompra;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas;

procedure TfrmCadTiposCotacaoPedidoCompra.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodTct, dbeDesTct, False);
end;

procedure TfrmCadTiposCotacaoPedidoCompra.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadTiposCotacaoPedidoCompra.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadTiposCotacaoPedidoCompra.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadTiposCotacaoPedidoCompra.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;


end;

procedure TfrmCadTiposCotacaoPedidoCompra.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodTct, dbeDesTct, False)
  Else
    pHabilitaCodigo(dbeCodTct, dbeDesTct, True);
end;

procedure TfrmCadTiposCotacaoPedidoCompra.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrAux: TConsultasArray;
begin
  chrKey := '/';
  If fPesqTipoCotacaoPedCpr(Self, Nil, Nil, qryTabela, chrKey, arrAux) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadTiposCotacaoPedidoCompra.FormCreate(Sender: TObject);
  Var
    strSQL: String;
begin
  inherited;
  strNomeTabela     := 'CADTCT';
  strNomeCampo      := 'TCT_CODTCT';

  strSQL            := 'SELECT * FROM CADTCT';
  qryCadTct         := fCriarQuery(strSQL, Self);
  qryTabela         := qryCadTct;
  dtsCadTct.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodTct;
end;

function TfrmCadTiposCotacaoPedidoCompra.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeCodTct) Then
    Begin
      If (fEmptyStr(dbeCodTct.Text)) And (dbeCodTct.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Tipo de Cotação deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeDesTct) Then
    Begin
      If fEmptyStr(dbeDesTct.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição do Tipo de Cotação deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End;
  End;
end;

procedure TfrmCadTiposCotacaoPedidoCompra.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('TCT_CODTCT');
  stlCampos.Add('TCT_DESTCT');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('TCT_DESTCT');
  stlCamInd.Add('TCT_CODTCT');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

end.
