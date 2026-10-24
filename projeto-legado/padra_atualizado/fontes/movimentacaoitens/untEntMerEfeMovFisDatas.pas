unit untEntMerEfeMovFisDatas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, ComboBoxFocus, Uni, Data.DB;

type
  TfrmEntMerEfeMovFisDatas = class(TfrmPaiConfirma)
    mskDtaSFo: TMaskEditFocus;
    mskDtaCTr: TMaskEditFocus;
    mskDtaEnt: TMaskEditFocus;
    mskDtaCEm: TMaskEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cmbNatOperacao: TComboBoxFocus;
    procedure cmbNatOperacaoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    qryNatOpe: TUniQuery;
    FAutoincremNaturezaOperacao: string;
    Function fValidaDataEntradaComADataBalancoDosItens(strDataEntrada: String): Boolean;
  public
    strCODEMP,
    strNUMDOC,
    strESPDOC,
    strSERIE_,
    strCODFOR: String;
    procedure pCarregaNaturezaOperacao;
    property AutoincremNaturezaOperacao: string read FAutoincremNaturezaOperacao;
  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean) : Boolean; Override;
  end;

var
  frmEntMerEfeMovFisDatas: TfrmEntMerEfeMovFisDatas;

implementation

{$R *.dfm}

uses
  untFuncoesSimples,
  untFechamentoEstoque,
  untFechamentoFiscal,
  untMensagemExplicativa, untMensagem;

{ TfrmEntMerEfeMovFisDatas }

procedure TfrmEntMerEfeMovFisDatas.cmbNatOperacaoChange(Sender: TObject);
begin
  inherited;
  if not fEmptyStr(cmbNatOperacao.Text) then
  Begin
    qryNatOpe.RecNo := cmbNatOperacao.ItemIndex + 1;
    FAutoincremNaturezaOperacao := qryNatOpe.FieldByName('AUTOINCREM').AsString;
  End
  Else
    FAutoincremNaturezaOperacao := '';
end;

procedure TfrmEntMerEfeMovFisDatas.FormCreate(Sender: TObject);
begin
  inherited;
  qryNatOpe := fCriaQuery(Self);
  FAutoincremNaturezaOperacao := '';
end;

procedure TfrmEntMerEfeMovFisDatas.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryNatOpe);
  inherited;
end;

function TfrmEntMerEfeMovFisDatas.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);
  If Result Then
  Begin
    If (Sender.ClassName = TMaskEditFocus.ClassName) Then
    Begin
      If fEmptyDate( TMaskEditFocus(Sender).Text ) Then
      Begin
        Result := (Sender <> mskDtaEnt);

        If Not Result Then
          pMensagemOK('A Data de Entrada é Obriatória!');
      End
      Else
      Begin
        Result := StrToDateDef(TMaskEditFocus(Sender).Text,0) > 0;

        If not Result Then
          pMensagemOK('Digite uma data válida!');

        If Result And (Sender = mskDtaEnt) Then
        Begin
          If (Not TFechamentoEstoque.fDataDeEntradaPermitida(StrToDate(mskDtaEnt.Text))) Then
            Result := False

          Else If (Not TFechamentoFiscal.fDataFiscalPermitida(StrToDate(mskDtaEnt.Text))) Then
            Result := False;

          If (Result) Then
            Result := fValidaDataEntradaComADataBalancoDosItens(TMaskEditFocus(Sender).Text);
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
End;

function TfrmEntMerEfeMovFisDatas.fValidaDataEntradaComADataBalancoDosItens(
  strDataEntrada: String): Boolean;
Var
  qryMovimentacao: TUniQuery;
  frmMensagemExplicativa: TfrmMensagemExplicativa;
begin
  Result := True;
  qryMovimentacao := fCriaQuery();
  Try
    qryMovimentacao.Close;
    qryMovimentacao.SQL.Clear;

    qryMovimentacao.SQL.Add( 'SET @LINHAS = 0; ');
    qryMovimentacao.SQL.Add(' SELECT ');
    qryMovimentacao.SQL.Add(' ITE_CODITE,  ');
    qryMovimentacao.SQL.Add(' ITE_DTABAL,  ');
    qryMovimentacao.SQL.Add(' CONCAT(DET_CODITE, "-", DET_DESCRI, " - Data Balanço: ",DATE_FORMAT(ITE_DTABAL, "%d/%m/%Y")) AS ITEM,  ');
    qryMovimentacao.SQL.Add(' CAST((@LINHAS := @LINHAS + 1) AS CHAR(100) ) AS QTD  ');
    qryMovimentacao.SQL.Add(' FROM MOVDET ');
    qryMovimentacao.SQL.Add('   INNER JOIN ITEGER ON DET_CODITE = ITE_CODITE AND DET_CODEMP = ITE_CODEMP ');
    qryMovimentacao.SQL.Add(' WHERE DET_CODEMP = :CODEMP ');
    qryMovimentacao.SQL.Add('   AND DET_NUMDOC = :NUMDOC ');
    qryMovimentacao.SQL.Add('   AND DET_ESPDOC = :ESPDOC ');
    qryMovimentacao.SQL.Add('   AND DET_SERIE_ = :SERIE_ ');
    qryMovimentacao.SQL.Add('   AND DET_CODFOR = :CODFOR ');
    qryMovimentacao.SQL.Add(' HAVING(ITE_DTABAL >= DATE_FORMAT(STR_TO_DATE(:DTAENT, "%d/%m/%Y"), "%Y-%m-%d") ) ');
    qryMovimentacao.ParamByName('NUMDOC').Value := strNUMDOC;
    qryMovimentacao.ParamByName('ESPDOC').Value := strESPDOC;
    qryMovimentacao.ParamByName('SERIE_').Value := strSERIE_;
    qryMovimentacao.ParamByName('CODFOR').Value := strCODFOR;
    qryMovimentacao.ParamByName('CODEMP').Value := strCODEMP;
    qryMovimentacao.ParamByName('DTAENT').Value := strDataEntrada;
    qryMovimentacao.Open;

    {Não pode haver nenhum item com data de balanço maior que a data do movimento. req 310317}
    If ( Not qryMovimentacao.IsEmpty) Then
    Begin
      Result := False;
      pCriarFormularios(TfrmMensagemExplicativa , frmMensagemExplicativa);
      Try
        frmMensagemExplicativa.Caption := 'Itens com divergências';
        frmMensagemExplicativa.mmoInstru.Lines.Clear;
        frmMensagemExplicativa.mmoInstru.Lines.Add('Os itens abaixo não podem ter data de balanço maior ou igual a data de entrada!');
        frmMensagemExplicativa.mmoInstru.Lines.Add('Data da Entrada: ' + strDataEntrada  );
        frmMensagemExplicativa.mmoInstru.Lines.Add('');
        qryMovimentacao.First;
        While not qryMovimentacao.Eof Do
        Begin
          frmMensagemExplicativa.mmoInstru.Lines.Add(qryMovimentacao.FieldByName('ITEM').AsString);
          qryMovimentacao.Next;
        End;

        frmMensagemExplicativa.ShowModal;

      Finally
        FreeAndNil(frmMensagemExplicativa);
      End;
    End

  Finally
    FreeAndNil(qryMovimentacao);
  End;

End;

procedure TfrmEntMerEfeMovFisDatas.pCarregaNaturezaOperacao;

  function fSQL(strTabela: string): string;
  begin
    Result := '';
    Result := Result + ' SELECT NAT_DESCRI, AUTOINCREM ';
    Result := Result + '   FROM NATCFO ';
    Result := Result + '  WHERE NAT_CODCFO = (SELECT GER_CLAFIS ';
    Result := Result + '                        FROM ' + strTabela + ' ';
    Result := Result + '                       WHERE GER_CODEMP = :CODEMP ';
    Result := Result + '                         AND GER_NUMDOC = :NUMDOC ';
    Result := Result + '                         AND GER_ESPDOC = :ESPDOC ';
    Result := Result + '                         AND GER_SERIE_ = :SERIE_ ';
    Result := Result + '                         AND GER_CODFOR = :CODFOR) ';
  end;

begin
  qryNatOpe.Close;
  qryNatOpe.SQL.Clear;
  qryNatOpe.SQL.Add( fSQL('MOVGER') );
  qryNatOpe.ParamByName('NUMDOC').Value := strNUMDOC;
  qryNatOpe.ParamByName('ESPDOC').Value := strESPDOC;
  qryNatOpe.ParamByName('SERIE_').Value := strSERIE_;
  qryNatOpe.ParamByName('CODFOR').Value := strCODFOR;
  qryNatOpe.ParamByName('CODEMP').Value := strCODEMP;
  qryNatOpe.Open;

  if qryNatOpe.IsEmpty then
  begin
    qryNatOpe.Close;
    qryNatOpe.SQL.Clear;
    qryNatOpe.SQL.Add( fSQL('NOTGER') );
    qryNatOpe.ParamByName('NUMDOC').Value := strNUMDOC;
    qryNatOpe.ParamByName('ESPDOC').Value := strESPDOC;
    qryNatOpe.ParamByName('SERIE_').Value := strSERIE_;
    qryNatOpe.ParamByName('CODFOR').Value := strCODFOR;
    qryNatOpe.ParamByName('CODEMP').Value := strCODEMP;
    qryNatOpe.Open;
  end;

  qryNatOpe.First;
  FAutoincremNaturezaOperacao := '';
  cmbNatOperacao.Clear;

  If qryNatOpe.IsEmpty Then
    Exit;

  qryNatOpe.First;
  while not qryNatOpe.Eof do
  Begin
    cmbNatOperacao.Items.Add(qryNatOpe.FieldByName('NAT_DESCRI').AsString);
    qryNatOpe.Next;
  End;

  cmbNatOperacao.ItemIndex := 0;
  cmbNatOperacao.OnChange(cmbNatOperacao);
end;

end.
