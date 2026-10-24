unit untConsultaPreco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Menus, Buttons, ExtCtrls, 
  Uni, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmConsultaPreco = class(TfrmPai)
    Panel1: TPanel;
    Panel2: TPanel;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    pnlNomeProduto: TPanel;
    pnlValorProduto: TPanel;
    Shape3: TShape;
    StaticText6: TStaticText;
    edtCodBarra: TEditFocus;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    lbEmbagemFechada: TStaticText;
    pnlEmbagemFechada: TPanel;
    shpEmbagemFechada: TShape;
    procedure FormCreate(Sender: TObject);
    procedure edtCodBarraKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    qryTmpPesq: TUniQuery;

    procedure pConsultaItem;

  public
    { Public declarations }
    strCodCli: String;
    strTabPre: String;

  protected

    procedure pOnKeyDownEdits(Sender: TObject; var Key: Word;
      Shift: TShiftState); Override;
    procedure pEscapePressed; Override;  

  end;

var
  frmConsultaPreco: TfrmConsultaPreco;

implementation

uses untConsultas, untFuncoesSimples, untPesqAux, Data.DB, untCadPro, untTypesSistema;

{$R *.dfm}

{ TfrmConsultaPreco }

{*******************************************}
{* CONSULTA PREÇO DO PRODUTO               *}
{****************************************RL*}
procedure TfrmConsultaPreco.pConsultaItem;
  Var
    fltUnitar: Double;

    fltPreCus,
    fltPreVen,
    fltComVar,
    fltComAta,
    fltComDis,
    fltQtdDis,
    fltDesF07: Double;
    blnParticiona,
    blnPromo: Boolean;
    strCodPromocao,
    strComPro: String;
begin
  lbEmbagemFechada.Visible := False;
  Try

    If (Not fEmptyStr(edtCodBarra.Text)) And (edtCodBarra.Text <> '000000000000000') Then
    Begin
      pPesquisaCadIte(qryTmpPesq, qryTmpPesq, edtCodBarra.Text, '', True);
      If Not qryTmpPesq.IsEmpty Then
      Begin
        If fEmptyStr(strTabPre) Then
          strTabPre := '1';

        {*******************************************}
        {* CONSULTA PREÇOS DE PROMOÇÃO DO PRODUTO  *}
        {****************************************RL*}
        If fRetornaPrecosPromocao(qryTmpPesq.FieldByName('ITE_CODITE').AsString,
                                  strCodCli,
                                  VS_Date,
                                  1,
                                  0,
                                  0,
                                  0,
                                  fltPreCus,
                                  fltPreVen,
                                  fltComVar,
                                  fltComAta,
                                  fltComDis,
                                  fltQtdDis,
                                  fltDesF07,
                                  strComPro,
                                  strCodPromocao,
                                  blnParticiona,
                                  blnPromo,
                                  strTabPre,
                                  '') Then
        Begin
          fltUnitar := fltPreVen;
        End

        Else If (fCfgSis('PRVEMB', VarBoolean)) And
                (fCfgSis('PREEMB', VarInteger) = 2) And
                (qryTmpPesq.FieldByName('BAR_TABPRE').AsString='F') Then
        Begin
          fltUnitar := qryTmpPesq.FieldByName('ITE_PREVE' + strTabPre).AsFloat;
        End

        Else If (fCfgSis('PRVEMB', VarBoolean)) And
                (fCfgSis('PREEMB', VarInteger) = 2) Then
        Begin

          If (fEmptyStr(qryTmpPesq.FieldByName('BAR_TABPRE').AsString)) Or
             (SameText(VS_strTabVen[StrToInt(qryTmpPesq.FieldByName('BAR_TABPRE').AsString)], 'N')) Then
          Begin
            fMensagem('', 'Esta embalagem está configurada para utilizar uma tabela de preço inválida!', ['&Ok']);
            pSetFocus(edtCodBarra);
            Exit;
          End;

          fltUnitar := fRetornaPrecoCodBarraEmb(qryTmpPesq.FieldByName('ITE_CODITE').AsString,
                                                qryTmpPesq.FieldByName('BAR_CODBAR').AsString,
                                                VS_strCodEmp,
                                                qryTmpPesq.FieldByName('BAR_TABPRE').AsString,
                                                False);

        End
        Else If (fCfgSis('PRVEMB', VarBoolean)) And
                (fCfgSis('PREEMB', VarInteger) = 1) And
                (qryTmpPesq.FieldByName('BAR_PREVEN').AsFloat > 0.00) Then
        Begin
          fltUnitar := qryTmpPesq.FieldByName('BAR_PREVEN').AsFloat;
        End
        Else
          fltUnitar := qryTmpPesq.FieldByName('ITE_PREVE' + strTabPre).AsFloat;

        if (qryTmpPesq.FieldByName('BAR_EMBALA').AsFloat <> 0) and
           (qryTmpPesq.FieldByName('BAR_EMBALA').AsFloat <> 1) then
        begin
          lbEmbagemFechada.Visible := True;
          pnlEmbagemFechada.Caption := FloatToStrF(qryTmpPesq.FieldByName('BAR_EMBALA').AsFloat * fltUnitar, ffFixed, 12, 2);
        end;

        pnlNomeProduto.Caption  := qryTmpPesq.FieldByName('ITE_DESITE').AsString;
        pnlValorProduto.Caption := FloatToStrF(fltUnitar, ffFixed, 12, 2);

      End
      Else
      Begin

        pnlNomeProduto.Caption  := 'Produto não cadastrado !';
        pnlValorProduto.Caption := '...';

      End;
    End;
  Except
    On E: Exception Do
    Begin

      pnlNomeProduto.Caption  := 'Erro na leitura do código de barras do produto: ' + E.Message;
      pnlValorProduto.Caption := '...';

    End;
  End;
  pnlEmbagemFechada.Visible := lbEmbagemFechada.Visible;
  shpEmbagemFechada.Visible := lbEmbagemFechada.Visible;
  edtCodBarra.Clear;
  pSetFocus(edtCodBarra);

end;

{************************************************}
{* ROTINA ONKEYDOWNEDITS DO FRMPAI SOBREESCRITA *}
{*********************************************RL*}
procedure TfrmConsultaPreco.pOnKeyDownEdits(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //inherited;

  If (Key = VK_Return) Then
  Begin

    If Sender is TEditFocus Then
    Begin

      If TEditFocus(Sender).Tag = 98 Then
        pConsultaItem;

    End;

  End
  Else If (Key = VK_Escape) Then
    pEscapePressed;

end;

procedure TfrmConsultaPreco.FormCreate(Sender: TObject);
begin
  inherited;
  qryTmpPesq := fCriaQuery(Self);

  If fCfgSis('TIPBAR', varString) = '2' Then
   edtCodBarra.MaxLength := 43;

end;

procedure TfrmConsultaPreco.pEscapePressed;
begin
  inherited;

end;

{*******************************************}
{* CONSULTA DO PRODUTO                     *}
{****************************************RL*}
procedure TfrmConsultaPreco.edtCodBarraKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryItem: TUniQuery;
    arrSel: TConsultasArray;
begin
  inherited;
  If fEmptyStr(strTabPre) Then
    strTabPre := '1';

  qryItem := fCriaQuery(Self);
  If fPesqItem(conIteSimples, Self, Nil, Nil, qryItem, Key, arrSel, True, Nil, 'Consulta de Itens', strTabPre) Then
  Begin
    edtCodBarra.Text := fCampoTabela('BAR_CODBAR', 'ITEBAR',
                                     ['BAR_CODITE', 'BAR_PRINCI'],
                                     [qryItem.FieldByName('ITE_CODITE').AsString, 1]);
      
  End;
  FreeAndNil(qryItem);
end;

end.
