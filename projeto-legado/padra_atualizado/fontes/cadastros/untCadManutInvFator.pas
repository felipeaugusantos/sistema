unit untCadManutInvFator;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, ExtCtrls, Menus, Buttons, EditFocus, Uni,
  StrUtils, untfuncoesSimples, AppEvnts, Mask, MaskEditFocus, untTypesSistema,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadManutInvFator = class(TfrmPai)
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
    edtDesAbf: TEditFocus;
    Label4: TLabel;
    edtCodAbf: TEditFocus;
    btnCalcFator: TBitBtnLocked;
    procedure btnCalcularClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAlterarClick(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruExit(Sender: TObject);
    procedure mskLinGruChange(Sender: TObject);
    procedure rdgStatusClick(Sender: TObject);
    procedure edtCodAbfKeyPress(Sender: TObject; var Key: Char);
    procedure rdgInfoClick(Sender: TObject);
    procedure btnCalcFatorClick(Sender: TObject);
  private
    { Private declarations }
    arrCodAbf,
    arrLinGru: TConsultasArray;
    strCodAbf,
    strLinGru: String;

    Procedure pCalculaValorInv(Var fltTotal, fltParcial: Double; blnCalIni: Boolean = False);
    procedure pAtualizaSaldo;

    function fSetInventario: Boolean;
    function fSQLFiltroAjuste( blnSal_ML : Boolean ): String;
    procedure pAtualizaCaptionRadio;

  public
    { Public declarations }
    strNomTab: String;
    recPreInv: TPreInvValues;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadManutInvFator: TfrmCadManutInvFator;

implementation

uses untFuncoesConsulta, untConstantes,  untConsultas, untCalcFatorInventario;

{$R *.dfm}

function TfrmCadManutInvFator.fSQLFiltroAjuste( blnSal_ML : Boolean ): String;
  Var
    strSQL: String;
Begin
  strSQL := ' TRUE ';

  strSQL := strSQL + fStrLocateLinGru(mskLinGru, arrLinGru, 'S.ITE_CODGRU', 'CODGRU', False, True);
  strSQL := strSQL +  fStrLocate(edtCodAbf, arrCodAbf, 'S.ITE_CODABF', 'CODABF');

  If chkArrendondarSaldo.Checked And chkArrendondarSaldo.Visible Then
  Begin
    Case rdgSaldos.ItemIndex Of
      0 : strSQL := strSQL + ' AND IF(CADUNI.UNI_ITEFRA = "N",  ROUND(S.ITE_SALDOS), S.ITE_SALDOS) ' + IIF(blnSal_ML, '+ IF(IFNULL(S.ITE_CNV_ML, 0) > 0, IFNULL(S.ITE_SAL_ML, 0) / S.ITE_CNV_ML, 0)','') + '>= 0.0  ';
      1 : strSQL := strSQL + ' AND IF(CADUNI.UNI_ITEFRA = "N",  ROUND(S.ITE_SALDOS), S.ITE_SALDOS) ' + IIF(blnSal_ML, '+ IF(IFNULL(S.ITE_CNV_ML, 0) > 0, IFNULL(S.ITE_SAL_ML, 0) / S.ITE_CNV_ML, 0)','') + '< 0.0   ';
    End;
  End
  Else
  Begin
    Case rdgSaldos.ItemIndex Of
      0 : strSQL := strSQL + ' AND S.ITE_SALDOS ' + IIF(blnSal_ML, '+ IF(IFNULL(S.ITE_CNV_ML, 0) > 0, IFNULL(S.ITE_SAL_ML, 0) / S.ITE_CNV_ML, 0)','') + '>= 0.0  ';
      1 : strSQL := strSQL + ' AND S.ITE_SALDOS ' + IIF(blnSal_ML, '+ IF(IFNULL(S.ITE_CNV_ML, 0) > 0, IFNULL(S.ITE_SAL_ML, 0) / S.ITE_CNV_ML, 0)','') + '< 0.0   ';
    End;
  End;

  Case rdgStatus.ItemIndex Of
    0: strSQL := strSQL + ' AND S.ITE_ITEATI = "S" ';
    1: strSQL := strSQL + ' AND S.ITE_ITEATI = "N" ';
  End;

  Result := '(' + strSQL + ')';
End;

Procedure TfrmCadManutInvFator.pCalculaValorInv(Var fltTotal, fltParcial: Double; blnCalIni: Boolean = False);
  Var
    qryGen: TUniQuery;
    strFatSal,
    strFatPre: String;

    strFatSalPar,
    strFatPrePar: String;

    blnSal_ML : Boolean;
    strQuanti, strCampoPreco, strQtdDec, strQtdUni: string;
    intQtdDecDef : Integer;
begin
  strQtdDec := fCfgSis('DECQTD', varString);
  strQtdUni := fCfgSis('DECUNI', varString);

  strQtdDec := '4';
  strQtdUni := '4';

  blnSal_ML := fCampoExiste(strNomTab, 'ITE_SAL_ML');

  qryGen := fCriaQuery;
  With qryGen, SQL Do
  Begin
    Clear;

    strFatSal := ' IF(' + fSQLFiltroAjuste(blnSal_ML) + ', :FATSAL, 1) ';
    strFatPre := ' IF(' + fSQLFiltroAjuste(blnSal_ML) + ', :FATPRE, 1) ';

    strFatSalPar := ' IF(' + fSQLFiltroAjuste(blnSal_ML) + ', :FATSAL, 0) ';
    strFatPrePar := ' IF(' + fSQLFiltroAjuste(blnSal_ML) + ', :FATPRE, 0) ';

    If chkArrendondarSaldo.Checked And chkArrendondarSaldo.Visible Then
      strQuanti := 'ROUND(ROUND((IF(CADUNI.UNI_ITEFRA = "N",  ROUND(S.ITE_SALDOS), S.ITE_SALDOS) + ' +
                  'IF(IFNULL(S.ITE_CNV_ML, 0) > 0, IFNULL(S.ITE_SAL_ML, 0) / S.ITE_CNV_ML, 0)), ' + strQtdDec + '), ' + strQtdDec + ') '
    Else
      strQuanti := '(S.ITE_SALDOS + ' +
                   ' IF(IFNULL(S.ITE_CNV_ML, 0) > 0, IFNULL(S.ITE_SAL_ML, 0) / S.ITE_CNV_ML, 0)) ';

    If (fCfgSis('PREINV') = 'MED') Or (fCfgSis('PREINV') = 'ULT') then
      strCampoPreco := '(' + fPreInv('S', '', recPreInv.strCodigo) + ' / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV))'
    Else
      strCampoPreco := 'ROUND(' + fPreInv('S', '', recPreInv.strCodigo) + ' / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), ' + strQtdUni + ')';

    Add('SELECT');
    
    intQtdDecDef := 4;

    Add('SUM(' + fRoundSql('  IF(' + strCampoPreco + ' * ' + strFatPre + ' < 0.0, 0.0, ' + strCampoPreco + ' * ' + strFatPre +  ')', intQtdDecDef) + ' *  ' +
                                 '  IF(' + strCampoPreco + ' * ' + strFatPre + ' < 0.0, 0.0, ' + strQuanti + ' * ' + strFatSal + ') ) AS TOTAL, ');

    Add('SUM(' + fRoundSql('  IF(' + strCampoPreco + ' * ' + strFatPrePar + ' < 0.0, 0.0, ' + strCampoPreco + ' * ' + strFatPrePar +  ')', intQtdDecDef) + ' *  ' +
                                 '  IF(' + strCampoPreco + ' * ' + strFatPrePar + ' < 0.0, 0.0, ' + strQuanti + ' * ' + strFatSalPar + ') ) AS PARCIAL ');


    Add('FROM');
    Add(strNomTab);
    Add('  AS S');

    Add('INNER JOIN CADUNI   ON S.ITE_CODUNI =   UNI_CODUNI');
    Add('INNER JOIN CADITE I ON I.ITE_CODITE = S.ITE_CODITE');
    Add('INNER JOIN ITEGER G ON G.ITE_CODITE = S.ITE_CODITE AND G.ITE_CODEMP = S.ITE_CODEMP  ');

    Add('WHERE ');
    Add('  S.ITE_CODEMP = :CODEMP ');

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

    pSetaParam(mskLinGru.Text, arrLinGru, strLinGru, 'CODGRU', qryGen);
    pSetaParam(edtCodAbf.Text, arrCodAbf, strCodAbf, 'CODABF', qryGen);


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

procedure TfrmCadManutInvFator.pAtualizaSaldo;
  Var
    fltTotal, fltParcial: Double;
    intQtdDecDef : Integer;
begin
  pCalculaValorInv(fltTotal, fltParcial, True);

  If (fCfgSis('PREINV') = 'MED') Or (fCfgSis('PREINV') = 'ULT') then
    intQtdDecDef := 4
  else
    intQtdDecDef := 2;


  edtTotInv.Text := FloatToStrF(fltTotal, ffFixed, 12, intQtdDecDef);
  edtParInv.Text := FloatToStrF(fltParcial, ffFixed, 12, intQtdDecDef);
end;

function TfrmCadManutInvFator.fSetInventario: Boolean;
  Var
    qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery;
    With qryGen, SQL Do
    Begin
      Clear;
      qryGen.SQL.Add('INSERT INTO LOGINV (LOG_DTAOCO,  LOG_HOROCO,  LOG_CODOPE,  LOG_TABELA,  LOG_CODITE,  LOG_CODEMP,  LOG_PREANT,  LOG_PRENOV,  LOG_CAMPRE,  LOG_SALANT,  LOG_SALNOV,  LOG_SMLNOV,  LOG_SMLANT)');
      qryGen.SQL.Add('       (SELECT CURDATE(), ');
      qryGen.SQL.Add('                     CURTIME(), ');
      qryGen.SQL.Add('                     "'+strLoginUsuarioLogado+'" , ');
      qryGen.SQL.Add('                     "' + strNomTab + '", ');
      qryGen.SQL.Add('                     S.ITE_CODITE, ');
      qryGen.SQL.Add('                     S.ITE_CODEMP, ');
      qryGen.SQL.Add(                      fPreInv('S', '', fCfgSis('PREINV'), False) + ',');
      Case rdgInfo.ItemIndex Of
         0,
         2: Begin
              If (fCfgSis('PREINV') = 'MED') Or (fCfgSis('PREINV') = 'ULT') then
                qryGen.SQL.Add('ROUND(' + fPreInv('S', '', fCfgSis('PREINV')) + ' * :FATOR, 4),')
              Else
                qryGen.SQL.Add('ROUND(' + fPreInv('S', '', fCfgSis('PREINV')) + ' * :FATOR, ' + fCfgSis('DECUNI') + '),')
            End;
       Else
         qryGen.SQL.Add(fPreInv('S', '', fCfgSis('PREINV'), False) + ', ');
      End;
      qryGen.SQL.Add('"' + fPreInv('', '', fCfgSis('PREINV'), False) + '",');
      qryGen.SQL.Add('S.ITE_SALDOS,');
      Case rdgInfo.ItemIndex Of
        1,
        2 : Begin
              If chkArrendondarSaldo.Checked And chkArrendondarSaldo.Visible Then
                qryGen.SQL.Add('ROUND(IF(CADUNI.UNI_ITEFRA = "N",  ROUND(S.ITE_SALDOS * :FATOR), S.ITE_SALDOS * :FATOR),' + fCfgSis('DECQTD') + '),')
              Else
                qryGen.SQL.Add('ROUND(S.ITE_SALDOS * :FATOR, ' + fCfgSis('DECQTD') + '),');
            End;
        Else
          qryGen.SQL.Add('S.ITE_SALDOS,');


      End;
      qryGen.SQL.Add(' S.ITE_SAL_ML,');
      qryGen.SQL.Add(' S.ITE_SAL_ML FROM ' + strNomTab + ' S,   CADUNI,   CADITE I');
      qryGen.SQL.Add(' WHERE ');
      qryGen.SQL.Add('   S.ITE_CODUNI =   UNI_CODUNI AND ');
      qryGen.SQL.Add('   I.ITE_CODITE = S.ITE_CODITE AND ');
      qryGen.SQL.Add('   S.ITE_CODEMP = :CODEMP  ');

      Case rdgStatus.ItemIndex Of
        0: qryGen.SQL.Add(' AND S.ITE_ITEATI = "S"');
        1: qryGen.SQL.Add(' AND S.ITE_ITEATI = "N"');
      End;

      qryGen.SQL.Add(fStrLocateLinGru(mskLinGru, arrLinGru, 'S.ITE_CODGRU', 'CODGRU', False, True));
      qryGen.SQL.Add(fStrLocate(edtCodAbf, arrCodAbf, 'S.ITE_CODABF', 'CODABF'));

      If chkArrendondarSaldo.Checked And chkArrendondarSaldo.Visible Then
      Begin
        Case rdgSaldos.ItemIndex Of
          0 : qryGen.SQL.Add('  AND IF(CADUNI.UNI_ITEFRA = "N",  ROUND(S.ITE_SALDOS), S.ITE_SALDOS) + IF(IFNULL(S.ITE_CNV_ML, 0) > 0, IFNULL(S.ITE_SAL_ML, 0) / S.ITE_CNV_ML, 0) >= 0.0  ');
          1 : qryGen.SQL.Add('  AND IF(CADUNI.UNI_ITEFRA = "N",  ROUND(S.ITE_SALDOS), S.ITE_SALDOS) + IF(IFNULL(S.ITE_CNV_ML, 0) > 0, IFNULL(S.ITE_SAL_ML, 0) / S.ITE_CNV_ML, 0) < 0.0   ');
        End;
      End
      Else
      Begin
        Case rdgSaldos.ItemIndex Of
          0 : qryGen.SQL.Add('  AND S.ITE_SALDOS + IF(IFNULL(S.ITE_CNV_ML, 0) > 0, IFNULL(S.ITE_SAL_ML, 0) / S.ITE_CNV_ML, 0) >= 0.0  ');
          1 : qryGen.SQL.Add('  AND S.ITE_SALDOS + IF(IFNULL(S.ITE_CNV_ML, 0) > 0, IFNULL(S.ITE_SAL_ML, 0) / S.ITE_CNV_ML, 0) < 0.0   ');
        End;
      End;
      qryGen.SQL.Add(');');


      Add('UPDATE');
      Add(strNomTab);
      Add(' AS S, CADUNI, CADITE I');
      Add('SET ');

      Case rdgInfo.ItemIndex Of
        0,
        2: Begin
             If (fCfgSis('PREINV') = 'MED') Or (fCfgSis('PREINV') = 'ULT') then
               Add(fPreInv('S', '', recPreInv.strCodigo, False) + ' = ' + fRoundSql(fPreInv('S', '', recPreInv.strCodigo) + ' * :FATOR', 4))
             Else
               Add(fPreInv('S', '', recPreInv.strCodigo, False) + ' = ROUND(' + fPreInv('S', '', recPreInv.strCodigo) + ' * :FATOR, ' + fCfgSis('DECUNI') + ')');
           End;
      End;

      Case rdgInfo.ItemIndex Of
        2: Add(',');
      end;

      Case rdgInfo.ItemIndex Of
        1,
        2 : Begin
              If chkArrendondarSaldo.Checked And chkArrendondarSaldo.Visible Then
                Add('S.ITE_SALDOS = ROUND(IF(CADUNI.UNI_ITEFRA = "N",  ROUND(S.ITE_SALDOS * :FATOR), S.ITE_SALDOS * :FATOR),' + fCfgSis('DECQTD') + ')')
              Else
                Add('S.ITE_SALDOS = ROUND(S.ITE_SALDOS * :FATOR, ' + fCfgSis('DECQTD') + ')');
            End;
      End;

      Add(' WHERE ');
      Add('   S.ITE_CODUNI =   UNI_CODUNI AND ');
      Add('   I.ITE_CODITE = S.ITE_CODITE AND ');
      Add('   S.ITE_CODEMP = :CODEMP          ');


      Case rdgStatus.ItemIndex Of
        0: Add(' AND S.ITE_ITEATI = "S"');
        1: Add(' AND S.ITE_ITEATI = "N"');
      End;

      Add(fStrLocateLinGru(mskLinGru, arrLinGru, 'S.ITE_CODGRU', 'CODGRU', False, True));
      Add(fStrLocate(edtCodAbf, arrCodAbf, 'S.ITE_CODABF', 'CODABF'));

      If chkArrendondarSaldo.Checked And chkArrendondarSaldo.Visible Then
      Begin
        Case rdgSaldos.ItemIndex Of
          0 : Add('  AND IF(CADUNI.UNI_ITEFRA = "N",  ROUND(S.ITE_SALDOS), S.ITE_SALDOS) + IF(IFNULL(S.ITE_CNV_ML, 0) > 0, IFNULL(S.ITE_SAL_ML, 0) / S.ITE_CNV_ML, 0) >= 0.0  ');
          1 : Add('  AND IF(CADUNI.UNI_ITEFRA = "N",  ROUND(S.ITE_SALDOS), S.ITE_SALDOS) + IF(IFNULL(S.ITE_CNV_ML, 0) > 0, IFNULL(S.ITE_SAL_ML, 0) / S.ITE_CNV_ML, 0) < 0.0   ');
        End;
      End
      Else
      Begin
        Case rdgSaldos.ItemIndex Of
          0 : Add('  AND S.ITE_SALDOS + IF(IFNULL(S.ITE_CNV_ML, 0) > 0, IFNULL(S.ITE_SAL_ML, 0) / S.ITE_CNV_ML, 0) >= 0.0  ');
          1 : Add('  AND S.ITE_SALDOS + IF(IFNULL(S.ITE_CNV_ML, 0) > 0, IFNULL(S.ITE_SAL_ML, 0) / S.ITE_CNV_ML, 0) < 0.0   ');
        End;
      End;

      ParamByName('FATOR').AsFloat   := fStrToFloat(edtFator.Text);
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      pSetaParam(mskLinGru.Text, arrLinGru, strLinGru,'CODGRU', qryGen);
      pSetaParam(edtCodAbf.Text, arrCodAbf, strCodAbf, 'CODABF', qryGen);
      ExecSQL;

      Result := True;
    End;
    FreeAndNil(qryGen);
  Except
    On e: Exception do
    Begin
      pMensagensErro(E.Message, '[TfrmCadManutInvFator.fSetInventario]');
      Result := False;
    End;
  End;
end;

procedure TfrmCadManutInvFator.btnCalcularClick(Sender: TObject);
  Var
    fltTotal, fltParcial: Double;
    intQtdDecDef: integer;
begin
  inherited;

  btnCalcular.Enabled := False;
  btnAlterar.Enabled  := False;
  pnlInfo.Caption     := 'Calculando inventário...';
  pnlInfo.Refresh;

  If fVerificaCampos Then
  Begin
    pCalculaValorInv(fltTotal, fltParcial);
    If (fCfgSis('PREINV') = 'MED') Or (fCfgSis('PREINV') = 'ULT') then
      intQtdDecDef := 4
    else
      intQtdDecDef := 2;

    edtTotInv.Text := FloatToStrF(fltTotal, ffFixed, 12, intQtdDecDef);
    edtParInv.Text := FloatToStrF(fltParcial, ffFixed, 12, intQtdDecDef);
  End;  

  pnlInfo.Caption := '';
  pnlInfo.Refresh;

  btnCalcular.Enabled := True;
  btnAlterar.Enabled  := True;

end;

procedure TfrmCadManutInvFator.edtCodAbfKeyPress(Sender: TObject;
  var Key: Char);
begin
  If (not edtCodAbf.ReadOnly) And fPesqAbrevFiscal(Self, edtCodAbf, edtDesAbf, Nil, Key, arrCodAbf, False) Then
  Begin
    If fValidaCampos(edtCodAbf, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadManutInvFator.pAtualizaCaptionRadio;
begin
  If recPreInv.strCodigo <> '' then
    rdgInfo.Items[0] := recPreInv.strDescri;
  edtDesGru.Text := 'NENHUM';
End;


procedure TfrmCadManutInvFator.FormShow(Sender: TObject);
begin
  inherited;

  edtCodAbf.MaxLength := IIf(fCfgSis('USASAN') = 'S', 7, 3);
  If recPreInv.strCodigo = '' Then
  Begin
    fMensagem('', 'Configure o campo que será utilizado para o cálculo do inventário.', ['&Ok']);
    Close;
    Exit;
  End;
  pAtualizaCaptionRadio;

  pAtualizaSaldo;

  If (Length(recPreInv.strCodigo) > 3) Then
    pSetFocus(rdgInfo.Controls[1] As TWinControl)
  Else
    pSetFocus(rdgInfo.Controls[0] As TWinControl);
end;


function TfrmCadManutInvFator.fValidaCampos(Sender: TWinControl;
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

    If Sender = edtCodAbf Then
    Begin
      If fEmptyStr(edtCodAbf.Text) Then
        edtDesAbf.Text := ''
      Else
      Begin
        If edtCodAbf.Text <> IIf(fCfgSis('USASAN') = 'S', '0000000', '000') Then
        Begin
          edtDesAbf.Text := fCampoTabela('ABF_DESABF', 'ABFICM', ['ABF_CODABF'], [edtCodAbf.Text]);
          If fEmptyStr(edtDesAbf.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Abreviação Fiscal não encontrada.', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadManutInvFator.mskLinGruChange(Sender: TObject);
begin
  inherited;
  pAtualizaSaldo;
end;

procedure TfrmCadManutInvFator.mskLinGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinGru, edtDesGru, arrLinGru, fRetNomeLinhaGrupo,Nil, 'da linha/grupo', 6, True);
end;

procedure TfrmCadManutInvFator.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinGru, edtDesGru, nil, Key, arrLinGru, False) then
  Begin
    If fValidaCampos(mskLinGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadManutInvFator.rdgInfoClick(Sender: TObject);
begin
  inherited;
  If ((rdgInfo.ItemIndex = 0) or (rdgInfo.ItemIndex = 2))  And
    (Length(recPreInv.strCodigo) > 3) Then
  Begin
    rdgInfo.ItemIndex := 1;
    fMensagem('Operação Não Permitida', 'Não é possivel ajustar esse campo devido a configuração do parametro PREINV!',['&OK']);
    Exit;
  End;
  pAtualizaSaldo;
  chkArrendondarSaldo.Visible :=  ((rdgInfo.ItemIndex = 1) or (rdgInfo.ItemIndex = 2));
  If chkArrendondarSaldo.Checked and (not chkArrendondarSaldo.Visible) Then
    chkArrendondarSaldo.Checked := False;
end;

procedure TfrmCadManutInvFator.rdgStatusClick(Sender: TObject);
begin
  inherited;
  pAtualizaSaldo;
end;

procedure TfrmCadManutInvFator.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmCadManutInvFator.btnCalcFatorClick(Sender: TObject);
begin
  inherited;
  pAtualizaSaldo;
  edtFator.Text := FormatFloat('#0.000000', TfrmCalcFatorInventario.fGetFator(edtParInv.Text));
end;

procedure TfrmCadManutInvFator.btnAlterarClick(Sender: TObject);
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

