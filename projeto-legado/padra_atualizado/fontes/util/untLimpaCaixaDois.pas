unit untLimpaCaixaDois;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, MaskEditFocus, Uni, BitBtnLockedIncrem;

type
  TfrmLimpaCaixaDois = class(TfrmPaiSimples)
    Panel1: TPanel;
    gpbPeriodo: TGroupBox;
    Label1: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label2: TLabel;
    mskDtaFin: TMaskEditFocus;
    gpbManterRegistros: TGroupBox;
    chkFaturamento: TCheckBox;
    chkMovimentoBancario: TCheckBox;
    chkResumoCaixa: TCheckBox;
    chkContasReceber: TCheckBox;
    chkManterNaoRecebidos: TCheckBox;
    chkContasPagar: TCheckBox;
    chkManterNaoPagos: TCheckBox;
    chkCheques: TCheckBox;
    chkManterNaoDepositados: TCheckBox;
    pnlConfirma: TPanel;
    BitBtn1: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    btnConfirmaDados: TBitBtnLocked;
    BitBtn2: TBitBtnLocked;
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure chkManterNaoRecebidosClick(Sender: TObject);
    procedure chkContasReceberClick(Sender: TObject);
    procedure chkContasPagarClick(Sender: TObject);
    procedure chkManterNaoPagosClick(Sender: TObject);
    procedure chkChequesClick(Sender: TObject);
    procedure chkManterNaoDepositadosClick(Sender: TObject);
  private
    { Private declarations }
    function fChecarCheckBox: Boolean;
    function fVerificaCampos: Byte;
    function fDeletaRegistrosCaixa2: Boolean;
    procedure pDeletaRegistros;

  public
    { Public declarations }
  end;

var
  frmLimpaCaixaDois: TfrmLimpaCaixaDois;

implementation

uses untFuncoes, untFuncoesSimples,  StrUtils;

{$R *.dfm}

procedure TfrmLimpaCaixaDois.btnCancelaDadosClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmLimpaCaixaDois.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  {**********************************************}
  {* OPÇÕES DE CHAMADA DE ROTINA DE EXCLUSÃO    *}
  {***************************07/08/09****** AM *}
  case fVerificaCampos of
    0: pDeletaRegistros; // se todos os requisitos foram satisfeitos

    1: If fMensagem('EXCLUIR TUDO',
       'O período de datas não está preenchido.'+#13+
       'Confirma excluir sem seleção de período ?',['&NÃO','&SIM']) = 2 Then
         Begin 
         mskDtaIni.Text := '01/01/1900';
         mskDtaFin.Text := '01/01/3999';
         pDeletaRegistros;
         mskDtaIni.Text := '';
         mskDtaFin.Text := '';
         End;

    2: fMensagem('AVISO', 'Nenhuma opção de limpeza foi escolhida !', ['&Ok']);
      
  End;
end;

Procedure TfrmLimpaCaixaDois.pDeletaRegistros;
Begin

  Screen.Cursor := crHourGlass;
  Application.ProcessMessages;

  fStartTransaction;

  If fDeletaRegistrosCaixa2 Then
  Begin
    fCommit;
    fMensagem('', 'Concluido com sucesso!', ['&Ok']);
  End
  Else
    fRollback;

  Screen.Cursor := crDefault;

End;

Function TfrmLimpaCaixaDois.fDeletaRegistrosCaixa2: Boolean;
  Var
    qryGenTmp: TUniQuery;
Begin

  Try
    qryGenTmp := fCriaQuery;

    Try
      
      If chkFaturamento.Checked Then
      Begin
        With qryGenTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('DELETE ');
          SQL.Add('FROM MOVGERX ');
          SQL.Add('WHERE ');
          SQL.Add('  GER_CODEMP = ' + VS_strCodEmp);
          SQL.Add(' AND TRUE ');

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
            SQL.Add('  AND GER_DTAENT BETWEEN :DTAINI AND :DTAFIN ');

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
          Begin
            ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
            ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
          End;

          ExecSQL;
          Close;

          SQL.Text := AnsiReplaceStr(SQL.Text, 'MOVGERX','NOTGERX');

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
            SQL.Add('  AND GER_DTAENT BETWEEN :DTAINI AND :DTAFIN ');

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
          Begin
            ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
            ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
          End;

          ExecSQL;
          Close;

        End;
      End;

      If chkMovimentoBancario.Checked Then
      Begin
        With qryGenTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('DELETE ');
          SQL.Add('FROM MOVBANX ');
          SQL.Add('WHERE ');
          SQL.Add('  CTB_CODEMP = ' + VS_strCodEmp);
          SQL.Add(' AND TRUE ');

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
            SQL.Add('  AND CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN ');

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
          Begin
            ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
            ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
          End;

          ExecSQL;
          Close;
        End;
      End;

      If chkResumoCaixa.Checked Then
      Begin
        With qryGenTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('DELETE ');
          SQL.Add('FROM CADRCXX ');
          SQL.Add('WHERE ');
          SQL.Add('  RCX_CODEMP = ' + VS_strCodEmp);
          SQL.Add(' AND TRUE ');


          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
            SQL.Add('  AND RCX_DTACAD BETWEEN :DTAINI AND :DTAFIN ');

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
          Begin
            ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
            ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
          End;

        ExecSQL;
        Close;
        End;
      End;

      If chkContasReceber.Checked Then
      Begin
        With qryGenTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('DELETE ');
          SQL.Add('FROM CADRECX ');
          SQL.Add('WHERE ');
          SQL.Add('  CTR_CODEMP = ' + VS_strCodEmp);
          SQL.Add(' AND TRUE ');

          If chkManterNaoRecebidos.Checked Then
            SQL.Add('  AND CTR_DTAREC IS NOT NULL ');

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
            SQL.Add('  AND CTR_DTACAD BETWEEN :DTAINI AND :DTAFIN ');

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
          Begin
            ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
            ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
          End;

          ExecSQL;

          Close;
          SQL.Clear;
          SQL.Add('DELETE ');
          SQL.Add('FROM DUPAGRX ');
          SQL.Add('WHERE ');
          SQL.Add('  CTR_CODEMP = ' + VS_strCodEmp);
          SQL.Add(' AND TRUE ');

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
            SQL.Add('  AND CTR_DTACAD BETWEEN :DTAINI AND :DTAFIN ');

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
          Begin
            ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
            ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
          End;

          ExecSQL;
          Close;
        End;
      End;

      If chkContasPagar.Checked Then
      Begin
        With qryGenTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('DELETE ');
          SQL.Add('FROM CADPAGX ');
          SQL.Add('WHERE ');
          SQL.Add('  CTP_CODEMP = ' + VS_strCodEmp);
          SQL.Add(' AND TRUE ');

          If chkManterNaoPagos.Checked Then
            SQL.Add('  AND CTP_DTAPAG IS NOT NULL ');

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
            SQL.Add('  AND CTP_DTACAD BETWEEN :DTAINI AND :DTAFIN ');

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
          Begin
            ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
            ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
          End;

          ExecSQL;

          Close;
          SQL.Clear;
          SQL.Add('DELETE ');
          SQL.Add('FROM DUPAGPX ');
          SQL.Add('WHERE ');
          SQL.Add('  CTP_CODEMP = ' + VS_strCodEmp);
          SQL.Add(' AND TRUE ');

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
            SQL.Add('  AND CTP_DTACAD BETWEEN :DTAINI AND :DTAFIN ');

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
          Begin
            ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
            ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
          End;

          ExecSQL;
          Close;
        End;
      End;

      If chkCheques.Checked Then
      Begin
        With qryGenTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT * ');
          SQL.Add('FROM CADCHQX ');
          SQL.Add('WHERE ');
          SQL.Add('  CHQ_CODEMP = ' + VS_strCodEmp);
          SQL.Add(' AND TRUE ');

          If chkManterNaoDepositados.Checked Then
            SQL.Add('  AND CHQ_DTADEP IS NOT NULL ');

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
            SQL.Add('  AND CHQ_DTACAD BETWEEN :DTAINI AND :DTAFIN ');

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
          Begin
            ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
            ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
          End;

          Open;
        End;

        fVerificaIntegridade(Self.Name, 'CADCHQX', qryGenTmp);

        With qryGenTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('DELETE ');
          SQL.Add('FROM CADCHQX ');
          SQL.Add('WHERE ');
          SQL.Add('  CHQ_CODEMP = ' + VS_strCodEmp);
          SQL.Add(' AND TRUE ');

          If chkManterNaoDepositados.Checked Then
            SQL.Add('  AND CHQ_DTADEP IS NOT NULL ');

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
            SQL.Add('  AND CHQ_DTACAD BETWEEN :DTAINI AND :DTAFIN ');

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
          Begin
            ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
            ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
          End;

          ExecSQL;
          Close;
        End;  
      End;

      Result := True;
    Except
      On E: Exception Do
      Begin
        pMensagensErro('Erro na deleção Senha Auxiliar: ' + E.Message, '[fDeleçãoSenha]');
        Result := False;
      End;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

End;


Function TfrmLimpaCaixaDois.fChecarCheckBox: Boolean;
  Var
    intContador: Integer;
Begin

  Result := False;

  For intContador := 0 To Self.ComponentCount -1 Do
  Begin
    If (Self.Components[intContador] Is TCheckBox) Then
    Begin
      If (Self.Components[intContador] As TCheckBox).Checked Then
      Begin
        Result := True;
        Exit;
      End;
    End;
  end;

End;

Function TfrmLimpaCaixaDois.fVerificaCampos: Byte;
begin

  Result := 0;

  If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
  Begin
     // NÃO HOUVE ESCOLHA DE PERÍODO DE DATAS [AM]
     If fChecarCheckBox then
       Result := 1  // Datas em branco, pelo menos um checkbox MARCADO [AM]
     Else
       Result := 2  // Datas em branco, NENHUM checkbox MARCADO [AM]

  end

  Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
  Begin
    If fCompDatas(mskDtaIni.Text, mskDtaFin.Text) Then
      If fChecarCheckBox then
        Result := 0  // SE DATA OK E PELO MENOS UM CHECKBOX MARCADO, SEGUE PROCESSO NORMAL [AM]
      Else
        Result := 2  // SE DATA OK MAS NENHUM checkbox MARCADO NÃO PERMITE AVANÇAR [AM]
  End

  Else If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
  Begin
    fMensagem('ATENÇÃO!', 'A data inicial deve ser preenchida!', ['&O k']);
    pSetFocus(mskDtaIni);
  End

  Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
  Begin
    fMensagem('ATENÇÃO!', 'A data final deve ser preenchida!', ['&O k']);
    pSetFocus(mskDtaFin);
  End;
end;

procedure TfrmLimpaCaixaDois.chkManterNaoRecebidosClick(Sender: TObject);
begin
  inherited;
  If chkManterNaoRecebidos.Checked Then
    chkContasReceber.Checked := True;
end;

procedure TfrmLimpaCaixaDois.chkContasReceberClick(Sender: TObject);
begin
  inherited;
  If Not chkContasReceber.Checked Then
    chkManterNaoRecebidos.Checked := False;

end;

procedure TfrmLimpaCaixaDois.chkContasPagarClick(Sender: TObject);
begin
  inherited;
  If Not chkContasPagar.Checked Then
    chkManterNaoPagos.Checked := False;
end;

procedure TfrmLimpaCaixaDois.chkManterNaoPagosClick(Sender: TObject);
begin
  inherited;
  If chkManterNaoPagos.Checked Then
    chkContasPagar.Checked := True;

end;

procedure TfrmLimpaCaixaDois.chkChequesClick(Sender: TObject);
begin
  inherited;
  If Not chkCheques.Checked Then
    chkManterNaoDepositados.Checked := False;

end;

procedure TfrmLimpaCaixaDois.chkManterNaoDepositadosClick(Sender: TObject);
begin
  inherited;
  If chkManterNaoDepositados.Checked Then
    chkCheques.Checked := True;
end;

end.
