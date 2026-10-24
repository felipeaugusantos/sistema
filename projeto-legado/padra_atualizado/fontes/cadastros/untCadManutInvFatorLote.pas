unit untCadManutInvFatorLote;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, ExtCtrls, Menus, Buttons, EditFocus, Uni,
  StrUtils, untfuncoesSimples, AppEvnts, Mask, MaskEditFocus, untTypesSistema,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadManutInvFatorLote = class(TfrmPai)
    rdgStatus: TRadioGroup;
    rdgInfo: TRadioGroup;
    Label1: TLabel;
    edtFator: TEditFocus;
    Label2: TLabel;
    edtTotInv: TEditFocus;
    mskLinGru: TMaskEditFocus;
    lbl1: TLabel;
    edtDesGru: TEditFocus;
    rdgSaldos: TRadioGroup;
    btnAlterar: TBitBtnLocked;
    btnCalcular: TBitBtnLocked;
    Label3: TLabel;
    edtParInv: TEditFocus;
    shpMultSel: TShape;
    chkArrendondarSaldo: TCheckBox;
    procedure btnCalcularClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAlterarClick(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruExit(Sender: TObject);
    procedure mskLinGruChange(Sender: TObject);
    procedure rdgInfoClick(Sender: TObject);
    procedure rdgStatusClick(Sender: TObject);
  private
    { Private declarations }

    arrLinGru: TConsultasArray;
    strLinGru: String;

    Procedure pCalculaValorInv(Var fltTotal, fltParcial: Double; blnCalIni: Boolean = False);
    procedure pAtualizaSaldo;

    function fSetInventario: Boolean;
    function fSQLFiltroAjuste( blnSal_ML : Boolean ): String;

  public
    { Public declarations }
    strNomTab,
    strPreInv: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadManutInvFatorLote: TfrmCadManutInvFatorLote;

implementation

uses untFuncoesConsulta, untConstantes,  untConsultas;

{$R *.dfm}

function TfrmCadManutInvFatorLote.fSQLFiltroAjuste( blnSal_ML : Boolean ): String;
  Var
    strSQL: String;
Begin
  strSQL := ' TRUE ';

  strSQL := strSQL + fStrLocateLinGru(mskLinGru, arrLinGru, 'S.ITE_CODGRU', 'CODGRU', False, True);

  If chkArrendondarSaldo.Checked Then
  Begin
    Case rdgSaldos.ItemIndex Of
      0 : strSQL := strSQL + ' AND IF(CADUNI.UNI_ITEFRA = "N",  ROUND(L.LOT_SALDOS), S.LOT_SALDOS) ' + IIF(blnSal_ML, '+ IF(IFNULL(I.ITE_CNV_ML, 0) > 0, IFNULL(S.LOT_SAL_ML, 0) / I.ITE_CNV_ML, 0)','') + '>= 0.0  ';
      1 : strSQL := strSQL + ' AND IF(CADUNI.UNI_ITEFRA = "N",  ROUND(L.LOT_SALDOS), S.LOT_SALDOS) ' + IIF(blnSal_ML, '+ IF(IFNULL(I.ITE_CNV_ML, 0) > 0, IFNULL(S.LOT_SAL_ML, 0) / I.ITE_CNV_ML, 0)','') + '< 0.0   ';
    End;
  End
  Else
  Begin
    Case rdgSaldos.ItemIndex Of
      0 : strSQL := strSQL + ' AND S.LOT_SALDOS ' + IIF(blnSal_ML, '+ IF(IFNULL(I.ITE_CNV_ML, 0) > 0, IFNULL(S.LOT_SAL_ML, 0) / I.ITE_CNV_ML, 0)','') + '>= 0.0  ';
      1 : strSQL := strSQL + ' AND S.LOT_SALDOS ' + IIF(blnSal_ML, '+ IF(IFNULL(I.ITE_CNV_ML, 0) > 0, IFNULL(S.LOT_SAL_ML, 0) / I.ITE_CNV_ML, 0)','') + '< 0.0   ';
    End;
  End;

  Case rdgStatus.ItemIndex Of
    0: strSQL := strSQL + ' AND S.ITE_ITEATI = "S" ';
    1: strSQL := strSQL + ' AND S.ITE_ITEATI = "N" ';
  End;

  Result := '(' + strSQL + ')';
End;

Procedure TfrmCadManutInvFatorLote.pCalculaValorInv(Var fltTotal, fltParcial: Double; blnCalIni: Boolean = False);
  Var
    qryGen: TUniQuery;
    strFatSal,
    strFatPre: String;

    strFatSalPar,
    strFatPrePar: String;

    blnSal_ML : Boolean;
    strQuanti, strCampoPreco, strQtdDec, strQtdUni: string;
begin
  strQtdDec := fCfgSis('DECQTD', varString);
  strQtdUni := fCfgSis('DECUNI', varString);

  blnSal_ML := fCampoExiste(strNomTab, 'LOT_SAL_ML');

  qryGen := fCriaQuery;
  With qryGen, SQL Do
  Begin
    Clear;

    strFatSal := ' IF(' + fSQLFiltroAjuste(blnSal_ML) + ', :FATSAL, 1) ';
    strFatPre := ' IF(' + fSQLFiltroAjuste(blnSal_ML) + ', :FATPRE, 1) ';

    strFatSalPar := ' IF(' + fSQLFiltroAjuste(blnSal_ML) + ', :FATSAL, 0) ';
    strFatPrePar := ' IF(' + fSQLFiltroAjuste(blnSal_ML) + ', :FATPRE, 0) ';

    If chkArrendondarSaldo.Checked Then
      strQuanti := 'ROUND(ROUND((IF(CADUNI.UNI_ITEFRA = "N",  ROUND(S.LOT_SALDOS), S.LOT_SALDOS) + ' +
                  'IF(IFNULL(I.ITE_CNV_ML, 0) > 0, IFNULL(S.LOT_SAL_ML, 0) / I.ITE_CNV_ML, 0)), ' + strQtdDec + '), ' + strQtdDec + ') '
    Else
      strQuanti := 'ROUND(ROUND((S.LOT_SALDOS + ' +
                   ' IF(IFNULL(I.ITE_CNV_ML, 0) > 0, IFNULL(S.LOT_SAL_ML, 0) / I.ITE_CNV_ML, 0)), ' + strQtdDec + '), ' + strQtdDec + ') ';

    strCampoPreco := 'ROUND(' + fPreInv('S', '', strPreInv) + ' / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), ' + strQtdUni + ')';

    Add('SELECT');
    Add('SUM(' + fRoundSql('  IF(' + strCampoPreco + ' * ' + strFatPre + ' < 0.0, 0.0, ' + strCampoPreco + ' * ' + strFatPre +  ') *  ' +
                                 '  IF(' + strCampoPreco + ' * ' + strFatPre + ' < 0.0, 0.0, ' + strQuanti + ' * ' + strFatSal + ') ', 2) + ') AS TOTAL, ');

    Add('SUM(' + fRoundSql('  IF(' + strCampoPreco + ' * ' + strFatPrePar + ' < 0.0, 0.0, ' + strCampoPreco + ' * ' + strFatPrePar +  ') *  ' +
                                 '  IF(' + strCampoPreco + ' * ' + strFatPrePar + ' < 0.0, 0.0, ' + strQuanti + ' * ' + strFatSalPar + ') ', 2) + ') AS PARCIAL ');

    Add('FROM');
    Add(strNomTab);
    Add('  AS S');

    Add('INNER JOIN CADUNI   ON S.ITE_CODUNI =   UNI_CODUNI');
    Add('INNER JOIN CADITE I ON I.ITE_CODITE = S.LOT_CODITE');

    Add('WHERE ');
    Add('  S.LOT_CODEMP = :CODEMP ');


    Case rdgInfo.ItemIndex Of
      0 : Begin
            ParamByName('FATPRE').AsFloat := fStrToFloat(edtFator.Text);
            ParamByName('FATSAL').AsFloat := 1;
          End;
      1 : Begin
            ParamByName('FATPRE').AsFloat := 1;
            ParamByName('FATSAL').AsFloat := fStrToFloat(edtFator.Text);
          End;
      2 : Begin
            ParamByName('FATPRE').AsFloat := fStrToFloat(edtFator.Text);
            ParamByName('FATSAL').AsFloat := fStrToFloat(edtFator.Text);
          End;
    End;

    ParamByName('CODEMP').AsString := VS_strCodEmp;

    pSetaParam(mskLinGru.Text, arrLinGru, strLinGru,'CODGRU', qryGen);

    If blnCalIni Then
    Begin
      ParamByName('FATPRE').AsFloat := 1;
      ParamByName('FATSAL').AsFloat := 1;
    End;

    Open;

    fltTotal   := FieldByName('TOTAL').AsFloat;
    fltParcial := FieldByName('PARCIAL').AsFloat;

  End;
  FreeAndNil(qryGen);
end;

procedure TfrmCadManutInvFatorLote.pAtualizaSaldo;
  Var
    fltTotal, fltParcial: Double;
begin
  pCalculaValorInv(fltTotal, fltParcial, True);

  edtTotInv.Text := FloatToStrF(fltTotal, ffFixed, 12, 2);
  edtParInv.Text := FloatToStrF(fltParcial, ffFixed, 12, 2);
end;

function TfrmCadManutInvFatorLote.fSetInventario: Boolean;
  Var
    qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery;
    With qryGen, SQL Do
    Begin
      Clear;

      Add('UPDATE');
      Add(strNomTab);
      Add(' AS S, CADUNI, CADITE I');
      Add('SET ');

      Case rdgInfo.ItemIndex Of
        0,
        2: Add(fPreInv('S', '', strPreInv, False) + ' = ROUND(' + fPreInv('S', '', strPreInv) + ' * :FATOR, ' + fCfgSis('DECUNI') + ')');
      End;

      Case rdgInfo.ItemIndex Of
        2: Add(',');
      end;

      Case rdgInfo.ItemIndex Of
        1,
        2 : Begin
              If chkArrendondarSaldo.Checked Then
                Add('S.LOT_SALDOS = ROUND(IF(CADUNI.UNI_ITEFRA = "N",  ROUND(S.LOT_SALDOS * :FATOR), S.LOT_SALDOS * :FATOR),' + fCfgSis('DECQTD') + ')')
              Else
                Add('S.LOT_SALDOS = ROUND(S.LOT_SALDOS * :FATOR, ' + fCfgSis('DECQTD') + ')');
            End;
      End;

      Add(' WHERE ');
      Add('   S.ITE_CODUNI =   UNI_CODUNI AND ');
      Add('   I.ITE_CODITE = S.LOT_CODITE AND ');
      Add('   S.LOT_CODEMP = :CODEMP          ');


      Case rdgStatus.ItemIndex Of
        0: Add(' AND I.ITE_ITEATI = "S"');
        1: Add(' AND I.ITE_ITEATI = "N"');
      End;

      Add(fStrLocateLinGru(mskLinGru, arrLinGru, 'S.ITE_CODGRU', 'CODGRU', False, True));

      If chkArrendondarSaldo.Checked Then
      Begin
        Case rdgSaldos.ItemIndex Of
          0 : Add('  AND IF(CADUNI.UNI_ITEFRA = "N",  ROUND(S.LOT_SALDOS), S.LOT_SALDOS) + IF(IFNULL(I.ITE_CNV_ML, 0) > 0, IFNULL(S.ITE_SAL_ML, 0) / I.ITE_CNV_ML, 0) >= 0.0  ');
          1 : Add('  AND IF(CADUNI.UNI_ITEFRA = "N",  ROUND(S.LOT_SALDOS), S.LOT_SALDOS) + IF(IFNULL(I.ITE_CNV_ML, 0) > 0, IFNULL(S.ITE_SAL_ML, 0) / I.ITE_CNV_ML, 0) < 0.0   ');
        End;
      End
      Else
      Begin
        Case rdgSaldos.ItemIndex Of
          0 : Add('  AND S.LOT_SALDOS + IF(IFNULL(I.ITE_CNV_ML, 0) > 0, IFNULL(S.ITE_SAL_ML, 0) / I.ITE_CNV_ML, 0) >= 0.0  ');
          1 : Add('  AND S.LOT_SALDOS + IF(IFNULL(I.ITE_CNV_ML, 0) > 0, IFNULL(S.ITE_SAL_ML, 0) / I.ITE_CNV_ML, 0) < 0.0   ');
        End;
      End;

      ParamByName('FATOR').AsFloat   := fStrToFloat(edtFator.Text);
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      pSetaParam(mskLinGru.Text, arrLinGru, strLinGru,'CODGRU', qryGen);
      ExecSQL;

      Result := True;
    End;
    FreeAndNil(qryGen);
  Except
    Result := False;
  End;
end;

procedure TfrmCadManutInvFatorLote.btnCalcularClick(Sender: TObject);
  Var
    fltTotal, fltParcial: Double;
begin
  inherited;

  btnCalcular.Enabled := False;
  btnAlterar.Enabled  := False;
  pnlInfo.Caption     := 'Calculando inventário...';
  pnlInfo.Refresh;

  If fVerificaCampos Then
  Begin
    pCalculaValorInv(fltTotal, fltParcial);

    edtTotInv.Text := FloatToStrF(fltTotal, ffFixed, 12, 2);
    edtParInv.Text := FloatToStrF(fltParcial, ffFixed, 12, 2);
  End;  

  pnlInfo.Caption := '';
  pnlInfo.Refresh;

  btnCalcular.Enabled := True;
  btnAlterar.Enabled  := True;

end;

procedure TfrmCadManutInvFatorLote.FormShow(Sender: TObject);
begin
  inherited;

  If Pos(strPreInv, CAMPOS_INV) <= 0 Then
  Begin
    fMensagem('', 'Configure o campo que será utilizado para o cálculo do inventário.', ['&Ok']);
    Close;
    Exit;
  End;

  If strPreInv = 'COM' then
  Begin
    rdgInfo.Items[0] := 'Preço de Compra';
  End

  Else If strPreInv = 'CUS' then
  Begin
    rdgInfo.Items[0] := 'Preço de Custo';
  End

  Else If strPreInv = 'VE1' then
  Begin
    rdgInfo.Items[0] := 'Preço de Venda 1';
  End

  Else If strPreInv = 'VE2' then
  Begin
    rdgInfo.Items[0] := 'Preço de Venda 2';
  End

  Else If strPreInv = 'VE3' then
  Begin
    rdgInfo.Items[0] := 'Preço de Venda 3';
  End

  Else If strPreInv = 'VE4' then
  Begin
    rdgInfo.Items[0] := 'Preço de Venda 4';
  End

  Else If strPreInv = 'VE5' then
  Begin
    rdgInfo.Items[0] := 'Preço de Venda 5';
  End

  Else If strPreInv = 'VE6' then
  Begin
    rdgInfo.Items[0] := 'Preço de Venda 6';
  End

  Else If strPreInv = 'VE7' then
  Begin
    rdgInfo.Items[0] := 'Preço de Venda 7';
  End
  Else If strPreInv = 'ULTFED' then
  Begin
    rdgInfo.Columns   := 1;
    rdgInfo.Items[0]  := 'Última compra menos impostos federais';
    rdgInfo.ItemIndex := 1;
  End
  Else If strPreInv = 'ULT' then
    rdgInfo.Items[0] := 'Preço de Última Compra'

  Else If strPreInv = 'IMPULT' then
    rdgInfo.Items[0] := 'Preço de Última Compra + Impostos Entrada'

  Else If strPreInv = 'PRELIQ' then
    rdgInfo.Items[0] := 'Preço de Compra Liquido';

  edtDesGru.Text := 'NENHUM';
  pAtualizaSaldo;

  pSetFocus(rdgInfo.Controls[0] As TWinControl);
end;


function TfrmCadManutInvFatorLote.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtFator) Then
    Begin
      If (fStrToFloat(edtFator.Text) <= 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadManutInvFatorLote.mskLinGruChange(Sender: TObject);
begin
  inherited;
  pAtualizaSaldo;
end;

procedure TfrmCadManutInvFatorLote.mskLinGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinGru, edtDesGru, arrLinGru, fRetNomeLinhaGrupo,Nil, 'da linha/grupo', 6, True);
end;

procedure TfrmCadManutInvFatorLote.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinGru, edtDesGru, nil, Key, arrLinGru, False) then
  Begin
    If fValidaCampos(mskLinGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadManutInvFatorLote.rdgInfoClick(Sender: TObject);
begin
  inherited;
  If ((rdgInfo.ItemIndex = 0) or (rdgInfo.ItemIndex = 2)) And
    (Length(strPreInv) > 3) Then
  Begin
    fMensagem('Operação Não Permitida', 'Não é possivel ajustar esse campo devido a configuração do parametro PREINV!',['&OK']);
    rdgInfo.ItemIndex := 1;
  End;
  pAtualizaSaldo;
  chkArrendondarSaldo.Visible :=  ((rdgInfo.ItemIndex = 1) or (rdgInfo.ItemIndex = 2));
  If chkArrendondarSaldo.Checked and (not chkArrendondarSaldo.Visible) Then
    chkArrendondarSaldo.Checked := False;
end;

procedure TfrmCadManutInvFatorLote.rdgStatusClick(Sender: TObject);
begin
  inherited;
  pAtualizaSaldo;
end;

procedure TfrmCadManutInvFatorLote.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key of
    VK_F3    : btnCalcular.Click;
    VK_ESCAPE: Close;
    VK_F10   : btnAlterar.Click;
    VK_Return: If (ActiveControl Is TRadioButton) Then
                 SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadManutInvFatorLote.btnAlterarClick(Sender: TObject);
begin
  inherited;

  btnAlterar.Enabled  := False;
  btnCalcular.Enabled := False;

  pnlInfo.Caption := 'Alterando inventário...';
  pnlInfo.Refresh;

  If fVerificaCampos Then
  Begin
    If fSetInventario Then
    Begin
      edtFator.Clear;
      pAtualizaSaldo;
      fMensagem('Ajuste de Inventário', 'Operação concluída com sucesso.', ['&Ok']);
    End;
  End;

  pnlInfo.Caption := '';
  pnlInfo.Refresh;

  btnAlterar.Enabled  := True;
  btnCalcular.Enabled := True;

end;

end.

