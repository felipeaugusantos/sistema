unit untBaixaOrdProdIndCorrecoes;

interface

uses
  Windows, Classes, Controls, untCadLote, Forms,
  untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  EditFocus, DBMemoFocus, Mask, DB, untOrdProIndCorrecoes,
   DBCtrls, DBEditFocus, ExtCtrls, frxClass, frxExportCSVTestabilidade, math;

type
  TfrmBaixaOrdProdIndCorrecoes = class(TfrmPaiEdit)
    btnConfirma: TBitBtnLocked;
    dbeSequen: TDBEditFocus;
    dbeCodIte: TDBEditFocus;
    dbeQtdIte: TDBEditFocus;
    dbeRefere: TDBEditFocus;
    dbeObserv: TDBMemoFocus;
    dtsItens: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dbeNumLot: TDbEditFocus;
    lblNumLot: TLabel;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure dbeNumLotKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
  private
    objCadLot : TCadLot;
    FPesquisaLoteApenasComLocalizacao: Boolean;

  public
    { Public declarations }
    blnConfirma: Boolean;
    objOrdCor: TOrdProIndCorrecoes;

    property blnPesquisaLoteApenasComLocalizacao: Boolean read FPesquisaLoteApenasComLocalizacao write FPesquisaLoteApenasComLocalizacao;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

uses SysUtils, untFuncoesSimples, untOrdProIndustrial, untConsultas, untTypesSistema;
{$R *.dfm}

procedure TfrmBaixaOrdProdIndCorrecoes.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    Close;
  End;
end;

procedure TfrmBaixaOrdProdIndCorrecoes.dbeCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqItem(conIteSimples, Self, dbeCodIte, dbeRefere, Nil, Key, arrSel, True,
               nil, 'Consulta de Itens', '1',
              '',0,False,False,0,cdrCodIte,'',False,'','',True,False, False,'',True, False, True) then
  Begin
    If fValidaCampos(dbeCodIte, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmBaixaOrdProdIndCorrecoes.dbeNumLotKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrLotes : TConsultasArray;
begin
  If fPesqLoteItens(Self, dbeNumLot, dbeCodite, fCfgSis('DECUNI', varInteger), nil, Key, arrLotes, true, '', '', true, False, nil, False, False, FPesquisaLoteApenasComLocalizacao) Then
    If fValidaCampos(dbeNumLot, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmBaixaOrdProdIndCorrecoes.FormCreate(Sender: TObject);
begin
  inherited;

  blnConfirma := False;

  lblNumLot.Visible := fUsaRotinaWMS;
  dbeNumLot.Visible := fUsaRotinaWMS;

  objCadLot := TCadLot.Create(Self);

  FPesquisaLoteApenasComLocalizacao:= False;

  pSetaCodIte(dbeCodIte);

end;

procedure TfrmBaixaOrdProdIndCorrecoes.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objCadLot);
  inherited;
end;

procedure TfrmBaixaOrdProdIndCorrecoes.FormShow(Sender: TObject);
begin
  inherited;

  dbeCodIte.ReadOnly := objOrdCor.State = dsEdit;
  dbeCodIte.TabStop  := Not dbeCodIte.ReadOnly;
end;

function TfrmBaixaOrdProdIndCorrecoes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    fltQtdUsa: Double;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If Sender = dbeSequen Then
    Begin

      If StrToIntDef(dbeSequen.Text, 0) <= 0 Then
      Begin
        Result := False;
        pMensagemOk('A sequência do item deve ser maior que zero!');
      End;

    End

    Else If Sender = dbeCodIte Then
    Begin

      If fEmptyStr(dbeCodIte.Text) Then
      Begin
        Result := False;
        pMensagemOk('Informe o Código do Produto!');
        dbeRefere.Clear;
      End Else
      Begin
        dbeRefere.Text := fRetNomProduto(dbeCodIte.Text);

        If fEmptyStr(dbeRefere.Text) Then
        Begin
          Result := False;
          pMensagemOk('Produto não encontrado!');
          dbeRefere.Clear;
        End

        Else If Pos(fCampoTabela('ITE_CODDEP', 'CADITE', ['ITE_CODITE'], [dbeCodIte.Text]),
                 fRetTipoDepartamento((fCampoTabela('ITE_CODDEP', 'CADITE', ['ITE_CODITE'], [dbeCodIte.Text])), 'PROMAP') + '_' +
                 fRetTipoDepartamento((fCampoTabela('ITE_CODDEP', 'CADITE', ['ITE_CODITE'], [dbeCodIte.Text])), 'PROEMB')) <= 0 Then
        Begin
          Result := False;
          pMensagemOk('Esse produto não é matéria prima/embalagem!');
        End

        Else If (objOrdCor.State = dsInsert) And objOrdCor.fJaIncluiuItem(dbeCodIte.Text) Then
        Begin
          If blnBuscaPorChave Then
          Begin
            If fPergunta('Esse produto já foi incluido na correção! '+#13
                         +'Deseja incluir novamente o mesmo item de correção?') Then
            Begin
              Result:= True;
              lblNumLot.Visible := fUsaRotinaWMS Or objCadLot.fExisteLote(dbeCodIte.Text, VS_strCodEmp, '');
              dbeNumLot.Visible := lblNumLot.Visible;
            End
            Else
            Begin
              dbeCodIte.Text:= '';
              dbeRefere.Text:= '';
              Result:= False;
            End;
          End;
        End
        else
        begin
          dtsItens.DataSet.FieldByName('DMT_DESCRI').AsString := dbeRefere.Text;

          lblNumLot.Visible := fUsaRotinaWMS Or objCadLot.fExisteLote(dbeCodIte.Text, VS_strCodEmp, '');
          dbeNumLot.Visible := lblNumLot.Visible;
        end;

      End;

    End

    Else If Sender = dbeQtdIte Then
    Begin

      If fStrToFloat(dbeQtdIte.Text) = 0 Then
      Begin
        Result := False;
        pMensagemOk('A quantidade deve ser diferente de zero!');
      End

      Else If (fStrToFloat(dbeQtdIte.Text) < 0) Then
      Begin
        fltQtdUsa := TOrdProIndustrial(objOrdCor.objOrdPro).fRetQuantidadeUsada(dbeCodIte.Text);

        If (RoundTo(Abs(fStrToFloat(dbeQtdIte.Text)),-4) > RoundTo(fltQtdUsa,-4)) Then
        Begin
          Result := False;
          pMensagemOk('O valor informado não deve ultrapassar a quantidade utilizada na produção ('+ FormatFloat('#0.0000', fltQtdUsa) + ')!');
        End;

      End;

    End

    Else If (Sender = dbeNumLot) And dbeNumLot.Visible Then
    Begin
      If (fEmptyStr(dbeNumLot.Text)) And (objCadLot.fExisteLote(dbeCodIte.Text, VS_strCodEmp, '')) Then
      Begin
        pMensagemOK('O item informado possui Lotes válidos. Informe um Lote!');
        Result := False;
      End

      Else If (Not fEmptyStr(dbeNumLot.Text)) And (Not objCadLot.fExisteLote(dbeCodIte.Text, VS_strCodEmp, dbeNumLot.Text)) Then
      Begin
        pMensagemOK('Informe um Lote Válido!');
        Result := False;
      End

      Else If (UpperCase(dbeNumLot.Text) = 'A DEFINIR') Then
      Begin
        pMensagemOK('Não é possível utilizar o Lote A DEFINIR!');
        Result := False;
      End

      else If (Not fEmptyStr(dbeNumLot.Text)) And (objCadLot.fEhPrincipalGarantia(dbeCodIte.Text, dbeNumLot.Text)) Then
      Begin
        pMensagemOK('Não é possível informar um lote principal para garantia!');
        Result := False;
      end;

    End

    Else If Sender = dbeObserv Then
    Begin

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

End.
