unit untFatExpServicosDigPed;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Uni,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls, EditFocus,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmFatExpServicosDigPed = class(TfrmPai)
    pnlFundo: TPanel;
    btnConfirma: TBitBtnLocked;
    Label1: TLabel;
    Label2: TLabel;
    edtNumPed: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    qryPed: TUniQuery;
    function fCarregaPedido: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }

  end;

var
  frmFatExpServicosDigPed: TfrmFatExpServicosDigPed;

implementation

uses untFuncoesSimples, Data.DB, untFuncoesAutocenter;

{$R *.dfm}

{ TfrmPai1 }

procedure TfrmFatExpServicosDigPed.btnConfirmaClick(Sender: TObject);
begin
  If fVerificaCampos Then
  Begin
    ModalResult := mrOk;
  End;
end;

procedure TfrmFatExpServicosDigPed.btnSairClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

function TfrmFatExpServicosDigPed.fCarregaPedido: Boolean;
begin
  qryPed.SQL.Clear;
  qryPed.SQL.Add('SELECT FDO_CODITE,FDO_SEQINC,');
  qryPed.SQL.Add('       (SELECT SUM(S.FDO_QTDITE * IF(S.FDO_ENTSAI = "S", 1, -1) )');
  qryPed.SQL.Add('          FROM FDOSEP S');
  qryPed.SQL.Add('         WHERE S.FDO_CODEMP = D.FDO_CODEMP');
  qryPed.SQL.Add('           AND S.FDO_NUMDOC = D.FDO_NUMDOC');
  qryPed.SQL.Add('           AND S.FDO_CODITE = D.FDO_CODITE');
  qryPed.SQL.Add('           AND S.FDO_SEQINC = E.FDO_SEQINC');
  qryPed.SQL.Add('           AND S.FDO_PENDEN = 0) AS QTDVOL'); //Quantidade a voltar
  qryPed.SQL.Add('  FROM FATDOR D');
  qryPed.SQL.Add('  JOIN EXTDOR E ON D.AUTOINCREM = E.FDO_SEQFDO');
  qryPed.SQL.Add('  JOIN FATGOR G ON G.AUTOINCREM = D.FDO_SEQGER');
  qryPed.SQL.Add(' WHERE FGO_CODEMP = :CODEMP');
  qryPed.SQL.Add('   AND FGO_NUMDOC = :NUMDOC');
  qryPed.SQL.Add('   AND FGO_ESPDOC = "PD"');

  qryPed.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryPed.ParamByName('NUMDOC').AsString := edtNumPed.Text;

  qryPed.Open;

  Result := Not qryPed.IsEmpty;
end;

procedure TfrmFatExpServicosDigPed.FormCreate(Sender: TObject);
begin
  inherited;
  qryPed := fCriaQuery;
  edtNumPed.MaxLength := fTamDocCadRec;
  edtNumPed.TamCampo  := fTamDocCadRec;
end;

procedure TfrmFatExpServicosDigPed.FormDestroy(Sender: TObject);
begin
  qryPed.Free;
  inherited;
end;

function TfrmFatExpServicosDigPed.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  Var
    strMsg: String;

  function fTemItemPendente: Boolean;
  begin
    Result := False;
    qryPed.First;
    While Not qryPed.Eof Do
    Begin
      If fFormataFloat(qryPed.FieldByName('QTDVOL').AsFloat, 2) <> 0.00 Then
        Result := True;
      qryPed.Next;
    End;
  end;

begin
  Result := True;

  If Sender = edtNumPed Then
  Begin
    If fEmptyStr(edtNumPed.Text) Then
      strMsg := 'Nº do Pedido deve ser preenchido!'

    Else
    Begin
      If Not fCarregaPedido Then
        strMsg := 'Nº do pedido não encontrado!'

      Else If Not fTemItemPendente Then
        strMsg := 'Pedido digitado não possui nenhum item pendente para voltar ao almoxarifado!'

      Else If fTemProdutosAguardandoConferenciaAlmoxarifado(edtNumPed.Text, 'PD', Vs_strCodEmp, 'S') Then
        strMsg := 'Existem saídas pendentes para conferência deste pedido. ' +
                  'Favor realizar a expedição antes de devolver os itens ao almoxarifado!'

      Else If fTemProdutosAguardandoConferenciaAlmoxarifado(edtNumPed.Text, 'PD', Vs_strCodEmp, 'E') Then
        strMsg := 'Já existem entradas pendentes para conferência deste pedido. ' +
                  'Favor realizar a expedição antes de devolver os itens ao almoxarifado!';
    End;
  End;

  If Not fEmptyStr(strMsg) Then
  Begin
    Result := False;
    fMensagem('', strMsg, ['&O k']);
    pSetFocus(Sender);
  End;
end;

end.
