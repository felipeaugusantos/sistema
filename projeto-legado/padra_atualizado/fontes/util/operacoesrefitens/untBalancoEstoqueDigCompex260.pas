unit untBalancoEstoqueDigCompex260;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Grids, DBGridCitel, DBGrids, Uni,
  untCadLote, DB, UniClientDataSet, UniDataSetProvider,  
  untModulo, BitBtnLockedIncrem, MemDS, DBAccess, Datasnap.Provider, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient;

type
  TfrmBalancoEstoqueDigCompex260 = class(TfrmPaiConfirma)
    pnlItens: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    edtCodIte: TEditFocus;
    pnlDigitador: TPanel;
    lblDigita: TLabel;
    edtSenDig: TEditFocus;
    edtNomDig: TEditFocus;
    Label4: TLabel;
    edtSldCon: TEditFocus;
    dbgConsulta: TDBGridCitel;
    qryConsulta: TUniQuery;
    dspConsulta: TUniDataSetProvider;
    cdsConsulta: TUniClientDataSet;
    dtsConsulta: TDataSource;
    pnlTail: TPanel;
    rdgMostrar: TRadioGroup;
    btnEcxluir: TBitBtnLocked;
    btnQuantidade: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure btnEcxluirClick(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure rdgMostrarClick(Sender: TObject);
    procedure btnQuantidadeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    objCadLot: TCadLot;
    qryConIte: TUniQuery;
    blnConAcu: Boolean;
    strCodDig: String;
    intConEst: Integer;
    stlListSelecao: TStringList;

    Function fAbreConsulta: Boolean;

    procedure pCarregaProduto;
    procedure pSalvaContagem;
    procedure pAtualiza(strCodIte: String);
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmBalancoEstoqueDigCompex260: TfrmBalancoEstoqueDigCompex260;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples, untBalancoEstoqueAjuste, System.UITypes;

procedure TfrmBalancoEstoqueDigCompex260.FormCreate(Sender: TObject);
begin
  inherited;

  WindowState := wsMaximized;

  qryConIte := fCriaQuery(Self);
  objCadLot := TCadLot.Create(Self);
  intConEst := fCfgSis('CONEST');
  blnConAcu := fCfgSis('CONACU', varBoolean);

  stlListSelecao := TStringList.Create;
  edtSldCon.Text := '1,000';

  qryConsulta.Connection := frmModulo.GetCurrentConnection;
end;

procedure TfrmBalancoEstoqueDigCompex260.FormDestroy(Sender: TObject);
begin
  inherited;

  stlListSelecao.Clear;
  FreeAndNil(stlListSelecao);
end;

procedure TfrmBalancoEstoqueDigCompex260.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F6: btnQuantidade.Click;
    VK_F8: btnEcxluir.Click;
  End;

end;

procedure TfrmBalancoEstoqueDigCompex260.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtSenDig);

  pSetaCodIte( edtCodIte );

end;

function TfrmBalancoEstoqueDigCompex260.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtSenDig) And (pnlDigitador.Enabled) Then
    Begin
      If fEmptyStr(edtSenDig.Text) Then
      Begin
        fMensagemAuto('ATENÇÃO!', 'O digitador deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        strCodDig      := fRetCodVendedor(edtSenDig.Text);
        edtNomDig.Text := fRetNomeOperador(strCodDig);

        If fEmptyStr(strCodDig) Then
        Begin
          fMensagemAuto('ATENÇÃO!', 'Esse digitador não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If Not fOperadorAtivo(strCodDig) Then
        Begin
          fMensagemAuto('ATENÇÃO!', 'Esse digitador está inativo!', ['&O k']);
          Result := False;
        End;
        If Result Then
        Begin
          pnlDigitador.Enabled  := False;
          pnlDigitador.Visible  := False;
          strLoginUsuarioLogado := strCodDig;
          Caption := 'Contagem - Operador: ' + strCodDig + '-' + edtNomDig.Text;

          pnlItens.Enabled      := True;
          pnlTail.Enabled       := True;
          btnEcxluir.Enabled    := True;
          btnQuantidade.Enabled := True;
        End;
      End;
    End

    Else If (Sender = edtCodIte) Then
    Begin

      If fEmptyStr(edtCodIte.Text) Then
      Begin
        fMensagemAuto('ATENÇÃO!', 'O Código do Item deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaProduto;
        If qryConIte.FieldByName('ITE_CODITE').IsNull Then
        Begin
          fMensagemAuto('ATENÇÃO!', 'Esse item não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If fValidaCampos(edtSldCon, True) Then
        Begin
          blnMudarFoco := False;
          pSalvaContagem;
        End;

      End;

    End

    Else If (Sender = edtSldCon) Then
    Begin

      If fEmptyStr(edtSldCon.Text) Or (fStrToFloat(edtSldCon.Text) < 0) Then
      Begin
        edtCodIte.Clear;
        Result := False;
        If Not edtSldCon.ReadOnly Then
        Begin
          fMensagemAuto('ATENÇÃO!', 'Informe a quantidade do produto!', ['&O k']);
          pSetFocus(edtSldCon);
          blnMudarFoco := False;
        End
        Else
          edtSldCon.Text := '1,000';
      End
      Else
      Begin
        edtSldCon.TabStop  := False;
        edtSldCon.ReadOnly := True;
      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmBalancoEstoqueDigCompex260.pCarregaProduto;

  function fSQL(blnCobBarEmb : boolean): String;
  Begin
    Result := '';
    Result := Result + 'SELECT ';
    Result := Result + '  I.ITE_ITEATI AS "ITE_ITEATI", ';
    Result := Result + '  I.ITE_CODITE AS "ITE_CODITE", ';
    Result := Result + '  I.ITE_CODGRU AS "ITE_CODGRU", ';
    Result := Result + '  P.GRU_DESGRU AS "GRU_DESGRU", ';
    Result := Result + '  I.ITE_DESITE AS "ITE_DESITE", ';
    Result := Result + '  I.ITE_REFERE AS "ITE_REFERE", ';
    Result := Result + '  I.ITE_CODUNI AS "ITE_CODUNI", ';
    Result := Result + '  U.UNI_DESUNI AS "UNI_DESUNI", ';
    Result := Result + '  I.ITE_CODMAR AS "ITE_CODMAR", ';
    Result := Result + '  M.MAR_DESMAR AS "MAR_DESMAR", ';
    Result := Result + '  I.ITE_CODFOR AS "ITE_CODFOR", ';
    Result := Result + '  F.FOR_NOMFOR AS "FOR_NOMFOR", ';
    Result := Result + '  G.ITE_SALDOS AS "ITE_SALDOS", ';
    Result := Result + '  G.ITE_SALBAL AS "ITE_SALBAL", ';
    Result := Result + '  G.ITE_DTABAL AS "ITE_DTABAL", ';
    Result := Result + '  G.ITE_SAL_ML AS "ITE_SAL_ML", ';
    Result := Result + '  I.ITE_CNV_ML AS "ITE_CNV_ML", ';
    Result := Result + '  G.ITE_SALCON AS "ITE_SALCON", ';
    Result := Result + '  G.ITE_GMLCON AS "ITE_GMLCON", ';
    Result := Result + '  G.ITE_DIFSAL AS "ITE_DIFSAL", ';

    If (blnCobBarEmb) Then
      Result := Result + '  E.BAR_EMBALA AS "BAR_EMBALA", ';

    Result := Result + '  G.ITE_DIF_ML AS "ITE_DIF_ML"  ';

    Result := Result + 'FROM ';
    Result := Result + '  CADITE I, ';

    If (blnCobBarEmb) Then
      Result := Result + '  ITEBAR E, ';

    Result := Result + '  CADUNI U, ';
    Result := Result + '  CADMAR M, ';
    Result := Result + '  CADFOR F, ';
    Result := Result + '  CADGRU P, ';
    Result := Result + '  ITEGER G ';
    Result := Result + 'WHERE ';

    If Length(edtCodIte.Text) <= fTamCodIte Then
    Begin
      Result := Result + '  I.ITE_CODITE = :CODITE AND ';
      edtCodIte.Text := fStrZero(edtCodIte.Text, fTamCodIte);
    End
    Else
    Begin
      If (blnCobBarEmb) Then
        Result := Result + '  E.BAR_CODBAR = :CODITE AND '
      Else
        Result := Result + '  I.ITE_CODBAR = :CODITE AND ';
    End;

    Result := Result + '  G.ITE_CODITE = I.ITE_CODITE AND ';

    If (blnCobBarEmb) Then
      Result := Result + '  E.BAR_CODITE = I.ITE_CODITE AND ';

    Result := Result + '  G.ITE_CODEMP = :CODEMP AND ';      //Empresa Atual
    Result := Result + '  I.ITE_CODUNI = U.UNI_CODUNI AND ';
    Result := Result + '  I.ITE_CODMAR = M.MAR_CODMAR AND ';
    Result := Result + '  I.ITE_CODGRU = P.GRU_CODGRU AND ';
    Result := Result + '  I.ITE_CODFOR = F.FOR_CODFOR ';
  End;

begin

  With qryConIte Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(fSQL(False));
    ParamByName('CODITE').AsString := edtCodIte.Text;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;

    If (IsEmpty) Then
    Begin

      Close;
      SQL.Clear;
      SQL.Add(fSQL(True));
      ParamByName('CODITE').AsString := edtCodIte.Text;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      If Not IsEmpty Then
      Begin
        If (edtSldCon.ReadOnly = True) Then
        Begin
          edtSldCon.ReadOnly := False;
          edtSldCon.Text     := FormatFloat('#0.000', fStrToFloat(edtSldCon.Text) * FieldByName('BAR_EMBALA').AsFloat);
          edtSldCon.ReadOnly := True;
        End
        Else
          edtSldCon.Text     := FormatFloat('#0.000', fStrToFloat(edtSldCon.Text) * FieldByName('BAR_EMBALA').AsFloat);
      End;

    End;

    edtCodIte.Text    := FieldByName('ITE_CODITE').AsString;
  End;
  
end;

procedure TfrmBalancoEstoqueDigCompex260.pSalvaContagem;
  Var blnImpLis: Boolean;
Begin
  blnImpLis := False;

  With qryConIte Do
  If ((FieldByName('ITE_ITEATI').AsString = 'S') Or fAtivarItem(edtCodIte.Text, blnImpLis)) Then
    fSalvaContagem(edtCodIte.Text, fStrToFloat(edtSldCon.Text), 0, objCadLot.fRetOrdemItem, True, blnImpLis, blnConAcu,
                   intConEst, strCodDig, '', Self);

  pAtualiza(edtCodIte.Text);

  edtSldCon.Text     := '1,000';
  edtSldCon.TabStop  := False;
  edtSldCon.ReadOnly := True;

  edtCodIte.Clear;
  pSetFocus(edtCodIte);
End;

procedure TfrmBalancoEstoqueDigCompex260.rdgMostrarClick(Sender: TObject);
begin
  inherited;

  fAbreConsulta;
  edtCodIte.Clear;
  pSetFocus(edtCodIte);
end;

procedure TfrmBalancoEstoqueDigCompex260.pAtualiza(strCodIte: String);
  Var
    intIndice: Integer;
Begin
  If Not stlListSelecao.Find(QuotedStr(strCodIte), intIndice) Then
    stlListSelecao.Add(QuotedStr(strCodIte));

  fAbreConsulta;
End;

procedure TfrmBalancoEstoqueDigCompex260.btnQuantidadeClick(Sender: TObject);
begin
  inherited;

  If (Not btnQuantidade.Enabled) Then
    Exit;

  edtSldCon.ReadOnly := False;
  edtSldCon.TabStop  := True;
  pSetFocus(edtSldCon);

end;

procedure TfrmBalancoEstoqueDigCompex260.btnEcxluirClick(Sender: TObject);
begin
  inherited;

  With cdsConsulta Do
    If Active And (Not IsEmpty) And
       (fMensagemAuto('', 'Zerar a contagem do item ' + FieldByName('ITE_CODITE').AsString + '?', ['&Sim', '&Nao']) = 1) Then
  Begin
    pZeraContagem(cdsConsulta, objCadLot, stlListSelecao, Self);
    fAbreConsulta;
    edtCodIte.Clear;
    pSetFocus(edtCodIte);
  End;
end;

procedure TfrmBalancoEstoqueDigCompex260.dbgConsultaDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  With dbgConsulta.Canvas Do
  Begin
    If cdsConsulta.IsEmpty Then
      Exit;

    If (stlListSelecao.Count > 0) And
       (stlListselecao.IndexOf(QuotedStr(cdsConsulta.FieldByName('ITE_CODITE').AsString)) > -1) Then
    Begin

      If Brush.Color = clHighLight Then
      Begin
        Font.Color := clHighLightText;
      End Else
      Begin
        Brush.Color := clMoneyGreen;
      End;

    End;
  End;

  dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

Function TfrmBalancoEstoqueDigCompex260.fAbreConsulta: Boolean;
Begin
  qryConsulta.Close;
  cdsConsulta.Close;

  qryConsulta.SQL.Text := fSqlContagem(rdgMostrar.ItemIndex = 1, stlListSelecao, Nil, False);
  qryConsulta.SQL.Add('ORDER BY ITE_ORDCON');
  cdsConsulta.Open;
  Result := True;
End;

end.

