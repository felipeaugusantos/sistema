{***********************}
{* qryConIte -> CADITE *}
{********************JB*}

unit untFatTrocaBase;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, EditFocus, Menus, ComCtrls,
  Buttons, ExtCtrls, AppEvnts, Uni, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmFatTrocaBase = class(TfrmPaiSimples)
    pnlDados: TPanel;
    edtCodIte: TEditFocus;
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    edtDesIte: TEditFocus;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryConIte: TUniQuery;

    procedure pCarregaItem;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strCodBas: String;
    fltCusBas: Double;
    fltVenBas: Double;
    blnConfirma: Boolean;
  end;


implementation

uses untFuncoes, untfuncoesSimples, untPesqAux, untModulo, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmFatTrocaBase }

function TfrmFatTrocaBase.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodIte) Then
    Begin

      If (fEmptyStr(edtCodIte.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do item deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaItem;
        If (fEmptyStr(edtDesIte.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If (qryConIte.FieldByName('ITE_ITEBAS').AsString <> 'S') Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não é uma Base!', ['&O k']);
          Result := False;
        End;

      End;

    End;

  End;

end;

procedure TfrmFatTrocaBase.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    blnConfirma := True;
    Close;
  End;
end;

procedure TfrmFatTrocaBase.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

procedure TfrmFatTrocaBase.pCarregaItem;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  I.ITE_DESITE, ';
  strSQL := strSQL + '  I.ITE_ITEBAS, ';
  strSQL := strSQL + '  G.ITE_PRECUS, ';
  strSQL := strSQL + '  G.ITE_PREVE1 ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE I, ';
  strSQL := strSQL + '  ITEGER G ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE AND ';
  strSQL := strSQL + '  I.ITE_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  I.ITE_CODITE = :CODITE ';

  With qryConIte Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('CODITE').AsString := edtCodIte.Text;
    Open;

    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
    fltCusBas      := FieldByName('ITE_PRECUS').AsFloat;
    fltVenBas      := FieldByName('ITE_PREVE1').AsFloat;
  End;
end;

procedure TfrmFatTrocaBase.FormShow(Sender: TObject);
begin
  inherited;
  edtCodIte.Text := strCodBas;
  pCarregaItem;

  pSetaCodIte( edtCodIte );

end;

procedure TfrmFatTrocaBase.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
begin
  inherited;
  Key := #0;
  chrKey := Key;
  Try
    {******************************************************************}
    {* NÃO CHAMA MAIS A COSULTA ESPECÍFICA, AGORA CHAMA A NOVA FUNÇÃO *}
    {***************************************************************AC*}

    //Obs : Não consegui testar(Perguntei para o Alexandre e ele também não conseguiu me dizer onde testar).

    if fPesqItem(conIteSimples,
                 Self,
                 edtCodIte,
                 edtDesIte,
                 qryConIte,
                 chrKey,
                 arrSel,
                 True,
                 Nil,
                 'Consulta de Itens',
                 '1',
                 '',
                 0,
                 false,
                 false,
                 0) Then
    Begin
      edtCodIte.Text := qryConIte.FieldByName('ITE_CODITE').AsString;
      If (fValidaCampos(edtCodIte, True)) Then
        SelectNext(ActiveControl, True, True);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[untFatTrocaBase.edtCodIte]');
    End;
  End;

end;

end.

