unit untCfgSugExp;

interface

uses Vcl.Controls, Vcl.ExtCtrls, System.SysUtils, Uni, ComboBoxFocus,
     cxImageComboBox, System.Classes, Vcl.StdCtrls, Variants, Data.Db,
     cxCheckListBox, EditFocus, Vcl.Forms;

type
  TCfgSugExp = Class
  private
  public
    class procedure pGravarSugestoesNoBanco(strNome, strValor: String;
      blnGravaOperadorLogado: Boolean=False);
    class procedure pGravaChaveEValorSugestao(WinControl: TWinControl;
      blnGravaOperadorLogado: Boolean=False);
    class procedure pRemoverEventoControls(const WinControl: TWinControl;
      const stlNomeComponentesExcecao: TStrings=Nil);
    class procedure pCarregarSugestoes(WinControl: TWinControl;
      blnCarregaOperadorLogado: Boolean=False);
    class function  fCarregaTAmanhoFonte(strNome: string): integer;
    class procedure pDefinirDescricaoDefaultNosFiltros(WinControl: TWinControl);
    class function fCarregaCampoParaFocus(ANomeFormulario: string;
      blnCarregaOperadorLogado: Boolean=False): string;
    class function fRetornaValorSusgetao(ANomeCampo: string;
      blnCarregaOperadorLogado: Boolean=False): String;
    class procedure pDesabilitaTodosComponentesExcetoArrayControl(
      const control: TControl;
      const stlNomeComponentesExcecao: TStrings;
      const blnPermiteOcultarCampos: Boolean=False);
  End;

implementation

{ TCfgSugExp }

uses untFuncoesSimples;

class procedure TCfgSugExp.pGravarSugestoesNoBanco(strNome, strValor: String;
  blnGravaOperadorLogado: Boolean);
  Var
    qrySugExp : TUniQuery;
begin
  qrySugExp := fCriaQuery;
  fStartTransaction;
  Try
    Try
      With qrySugExp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Text := 'DELETE FROM SUGEXP '
                  + ' WHERE EXP_TIPEXP = :TIPEXP '
                  + '   AND EXP_CODEMP = :CODEMP '
                  + '   AND EXP_NAMOBJ = :NAMOBJ ';

        If blnGravaOperadorLogado Then
        Begin
          SQL.Text := SQL.Text
                    + '   AND EXP_CODOPE = :CODOPE ';
        End
        Else
        Begin
          SQL.Text := SQL.Text
                    + '   AND IFNULL(EXP_CODOPE,"") = "" ';
        End;

        ParamByName('TIPEXP').AsString := VS_strTipExp;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('NAMOBJ').AsString := strNome;

        If blnGravaOperadorLogado Then
          ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

        ExecSQL;
      End;

      With qrySugExp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Text := 'REPLACE INTO SUGEXP '
                  + '       (AUTOINCREM,  EXP_TIPEXP, EXP_CODEMP, '
                  + '        EXP_NAMOBJ,  EXP_SUGEST, EXP_CODOPE) '
                  + 'VALUES (:AUTOINCREM, :TIPEXP,    :CODEMP, '
                  + '        :NAMOBJ,     :SUGEST,    :CODOPE) ';

        ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('SUGEXP', VS_strCodEmp);
        ParamByName('TIPEXP').AsString     := VS_strTipExp;
        ParamByName('CODEMP').AsString     := VS_strCodEmp;
        ParamByName('NAMOBJ').AsString     := strNome;
        ParamByName('SUGEST').AsString     := strValor;

        If blnGravaOperadorLogado Then
          ParamByName('CODOPE').AsString := strLoginUsuarioLogado
        Else
          ParamByName('CODOPE').Value := Null;

        ExecSQL;
      End;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TCfgSugExp.pGravarSugestoesNoBanco]');
      End;
    End;
  Finally
    FreeAndNil(qrySugExp);
  End;
end;

class function TCfgSugExp.fCarregaCampoParaFocus(ANomeFormulario: string;
  blnCarregaOperadorLogado: Boolean): string;
var
  LqryCampoParaFoco: TUniQuery;
begin
  LqryCampoParaFoco := fCriaQuery;
  try
    LqryCampoParaFoco.Close;
    LqryCampoParaFoco.SQL.Text := 'SELECT EXP_SUGEST FROM SUGEXP '
                                + ' WHERE EXP_TIPEXP = :TIPEXP '
                                + '   AND EXP_CODEMP = :CODEMP '
                                + '   AND EXP_NAMOBJ = :NAMOBJ';

    If blnCarregaOperadorLogado Then
    Begin
      LqryCampoParaFoco.SQL.Text := LqryCampoParaFoco.SQL.Text
                                  + '   AND EXP_CODOPE = :CODOPE ';
    End
    Else
    Begin
      LqryCampoParaFoco.SQL.Text := LqryCampoParaFoco.SQL.Text
                                  + '   AND IFNULL(EXP_CODOPE,"") = "" ';
    End;

    LqryCampoParaFoco.ParamByName('TIPEXP').AsString := VS_strTipExp;
    LqryCampoParaFoco.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LqryCampoParaFoco.ParamByName('NAMOBJ').AsString := ANomeFormulario;

    If blnCarregaOperadorLogado Then
      LqryCampoParaFoco.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

    LqryCampoParaFoco.Open;

    if LqryCampoParaFoco.IsEmpty then
    begin
      Result := '';
    end
    else
    begin
      Result := LqryCampoParaFoco.FieldByName('EXP_SUGEST').AsString;
    end;
  finally
    FreeAndNil(LqryCampoParaFoco);
  end;

end;

class function TCfgSugExp.fCarregaTAmanhoFonte(strNome: string): integer;
var
  qryTamanoFonte: TUniQuery;
begin
  qryTamanoFonte := fCriaQuery;
  try
    qryTamanoFonte.Close;
    qryTamanoFonte.SQL.Add('SELECT EXP_SUGEST FROM SUGEXP     ');
    qryTamanoFonte.SQL.Add(' WHERE EXP_TIPEXP = :TIPEXP       ');
    qryTamanoFonte.SQL.Add('   AND EXP_CODEMP = :CODEMP       ');
    qryTamanoFonte.SQL.Add('   AND EXP_NAMOBJ = :NAMOBJ       ');
    qryTamanoFonte.SQL.Add('   AND IFNULL(EXP_CODOPE,"") = "" ');
    qryTamanoFonte.ParamByName('TIPEXP').AsString := VS_strTipExp;
    qryTamanoFonte.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTamanoFonte.ParamByName('NAMOBJ').AsString := strNome;
    qryTamanoFonte.Open;

    if qryTamanoFonte.IsEmpty then
    begin
      Result := 8;
    end
    else
    begin
      Result := StrToIntDef(qryTamanoFonte.FieldByName('EXP_SUGEST').AsString, 8);
    end;
  finally
    FreeAndNil(qryTamanoFonte);
  end;
end;

class function TCfgSugExp.fRetornaValorSusgetao(ANomeCampo: string;
  blnCarregaOperadorLogado: Boolean): String;
begin
  Result := fCarregaCampoParaFocus(ANomeCampo, blnCarregaOperadorLogado);
end;

class procedure TCfgSugExp.pCarregarSugestoes(WinControl: TWinControl;
  blnCarregaOperadorLogado: Boolean);

  Var
    qrySugExp : TUniQuery;
  function fGetIndexByName(Strings: TStrings; strValor: String; intDef: Integer): Integer;
    Var
      intCnt : Integer;
  begin
    Result := intDef;
    For intCnt := 0 To Strings.Count-1 Do
    Begin
      If SameText(strValor, Strings[intCnt]) Then
      Begin
        Result := intCnt;
        Break;
      End;
    End;
  end;

  procedure pSetarSugestao(WinControl: TWinControl);
    Var
      intCnt : Integer;
      intIdx: Integer;
      intLst: Integer;
      lstAux: TStringList;
      cxCheckList: TcxCheckListBox;
  begin
    For intCnt := 0 To WinControl.ControlCount-1 Do
    Begin
      If (WinControl.Controls[intCnt] Is TRadioGroup) Then
      Begin
        If (TRadioGroup(WinControl.Controls[intCnt]).Visible) Then
        Begin
          If qrySugExp.Locate('EXP_NAMOBJ', TRadioGroup(WinControl.Controls[intCnt]).Name, []) Then
            TRadioGroup(WinControl.Controls[intCnt]).ItemIndex := fGetIndexByName(TRadioGroup(WinControl.Controls[intCnt]).Items, qrySugExp.FieldByName('EXP_SUGEST').AsString, TRadioGroup(WinControl.Controls[intCnt]).ItemIndex);
        End;
      End
      Else If (WinControl.Controls[intCnt] Is TGroupBox) And (TGroupBox(WinControl.Controls[intCnt]).Visible) Then
        pSetarSugestao(TGroupBox(WinControl.Controls[intCnt]))

      Else If (WinControl.Controls[intCnt] Is TPanel) And (TPanel(WinControl.Controls[intCnt]).Visible) Then
        pSetarSugestao(TPanel(WinControl.Controls[intCnt]))

      Else If (WinControl.Controls[intCnt] Is TComboBoxFocus) Then
      Begin
        If (TComboBoxFocus(WinControl.Controls[intCnt]).Visible) Then
        Begin
          If qrySugExp.Locate('EXP_NAMOBJ', TComboBoxFocus(WinControl.Controls[intCnt]).Name, []) Then
            TComboBoxFocus(WinControl.Controls[intCnt]).ItemIndex := fGetIndexByName(TComboBoxFocus(WinControl.Controls[intCnt]).Items, qrySugExp.FieldByName('EXP_SUGEST').AsString, TComboBoxFocus(WinControl.Controls[intCnt]).ItemIndex);
        End;
      End
      Else If (WinControl.Controls[intCnt] Is TcxImageComboBox) Then
      Begin
        If (TcxImageComboBox(WinControl.Controls[intCnt]).Visible) Then
        Begin
          If qrySugExp.Locate('EXP_NAMOBJ', TcxImageComboBox(WinControl.Controls[intCnt]).Name, []) Then
          Begin
            If Not fEmptyStr(qrySugExp.FieldByName('EXP_SUGEST').AsString) Then
              TcxImageComboBox(WinControl.Controls[intCnt]).ItemIndex := StrToIntDef(qrySugExp.FieldByName('EXP_SUGEST').AsString, 0)
          End;
        End;
      End
      Else If (WinControl.Controls[intCnt] Is TcxCheckListBox) Then
      Begin
        cxCheckList := (WinControl.Controls[intCnt] As TcxCheckListBox);

        If cxCheckList.Visible Then
        Begin
          If qrySugExp.Locate('EXP_NAMOBJ', cxCheckList.Name, []) Then
          Begin
            lstAux := TStringList.Create();
            Try
              lstAux.Text := qrySugExp.FieldByName('EXP_SUGEST').AsString;

              For intLst := 0 To Pred(lstAux.Count) Do
              Begin
                intIdx := cxCheckList.Items.IndexOf(lstAux[intLst]);

                If (intIdx >= 0) Then
                  cxCheckList.Items[intIdx].Checked := True;
              End;
            Finally
              lstAux.Free;
            End;
          End;
        End;
      End
      Else If (WinControl.Controls[intCnt] Is TRadioButton) And (WinControl Is TGroupBox) And (WinControl.Visible) Then
      Begin
        If (qrySugExp.Locate('EXP_NAMOBJ', WinControl.Name, [])) And
           (qrySugExp.FieldByName('EXP_SUGEST').AsString.Equals(WinControl.Controls[intCnt].Name)) Then
          TRadioButton(WinControl.Controls[intCnt]).Checked := True;
      End;
    End;
  end;

begin
  qrySugExp := fCriaQuery;
  Try
    With qrySugExp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT * FROM SUGEXP '
                + ' WHERE EXP_TIPEXP = :TIPEXP '
                + '   AND EXP_CODEMP = :CODEMP ';

      If blnCarregaOperadorLogado Then
      Begin
        SQL.Text := SQL.Text
                  + '   AND EXP_CODOPE = :CODOPE ';
      End
      Else
      Begin
        SQL.Text := SQL.Text
                  + '   AND IFNULL(EXP_CODOPE,"") = "" ';
      End;

      ParamByName('TIPEXP').AsString := VS_strTipExp;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      If blnCarregaOperadorLogado Then
        ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

      Open;

      If (Not IsEmpty) Then
      Begin
        pSetarSugestao(WinControl);
      End;

      Close;
    End;
  Finally
    FreeAndNil(qrySugExp);
  End;
end;

class procedure TCfgSugExp.pDefinirDescricaoDefaultNosFiltros(WinControl: TWinControl);
  Var
    intCnt : Integer;
begin
  For intCnt := 0 To WinControl.ControlCount-1 Do
  Begin
    If (WinControl.Controls[intCnt] Is TPanel) And (TPanel(WinControl.Controls[intCnt]).Visible) Then
      pDefinirDescricaoDefaultNosFiltros(TPanel(WinControl.Controls[intCnt]))

    Else If (WinControl.Controls[intCnt] Is TGroupBox) And (TGroupBox(WinControl.Controls[intCnt]).Visible) Then
      pDefinirDescricaoDefaultNosFiltros(TGroupBox(WinControl.Controls[intCnt]))

    Else If (WinControl.Controls[intCnt] Is TEditFocus) Then
    begin
      if TEditFocus(WinControl.Controls[intCnt]).Enabled then
      begin
        TEditFocus(WinControl.Controls[intCnt]).CharCase := ecNormal;
        TEditFocus(WinControl.Controls[intCnt]).Text     := 'Foco';
        TEditFocus(WinControl.Controls[intCnt]).ReadOnly := True;
      end;
    end

    Else
      WinControl.Controls[intCnt].Enabled := False;
  End;
end;

class procedure TCfgSugExp.pDesabilitaTodosComponentesExcetoArrayControl(
  const control: TControl; const stlNomeComponentesExcecao: TStrings;
  const blnPermiteOcultarCampos: Boolean);
Var
  intCnt : Integer;
begin
  If (Not Assigned(stlNomeComponentesExcecao)) Or
     (Not Assigned(control)) Then
    Exit;

  For intCnt := 0 To Pred(control.ComponentCount) Do
  Begin
    If (Not (control.Components[intCnt] Is TForm)) And
       (Not (control.Components[intCnt] Is TPanel)) Then
    Begin
      If (control.Components[intCnt] Is TWinControl) Or
         (control.Components[intCnt] Is TGroupBox) Or
         (control.Components[intCnt] Is TLabel) Then
      Begin
        If TWinControl(control.Components[intCnt]).Enabled Then
          TWinControl(control.Components[intCnt]).Enabled := (stlNomeComponentesExcecao.IndexOf(control.Components[intCnt].Name) >= 0);

        If (blnPermiteOcultarCampos) And
           (TWinControl(control.Components[intCnt]).Visible) Then
          TWinControl(control.Components[intCnt]).Visible := (stlNomeComponentesExcecao.IndexOf(control.Components[intCnt].Name) >= 0);

        If (TWinControl(control.Components[intCnt]).Enabled) And
           (control.Components[intCnt] Is TGroupBox) Then
        Begin
          pDesabilitaTodosComponentesExcetoArrayControl(
            TControl(control.Components[intCnt]),
            stlNomeComponentesExcecao,
            blnPermiteOcultarCampos);
        End;
      End;
    End
    Else
    Begin
      pDesabilitaTodosComponentesExcetoArrayControl(
        TControl(control.Components[intCnt]),
        stlNomeComponentesExcecao,
        blnPermiteOcultarCampos);
    End;
  End;
end;

class procedure TCfgSugExp.pGravaChaveEValorSugestao(WinControl: TWinControl;
  blnGravaOperadorLogado: Boolean);
  Var
    intCnt : Integer;
    strChave, strValor: String;
    intIdx: Integer;
    cxCheckList: TcxCheckListBox;
begin
  strChave := '';
  strValor := '';

  For intCnt := 0 To WinControl.ControlCount-1 Do
  Begin
    If (WinControl.Controls[intCnt] Is TRadioGroup) Then
    Begin
      If TRadioGroup(WinControl.Controls[intCnt]).Visible Then
      Begin
        strChave := TRadioGroup(WinControl.Controls[intCnt]).Name;
        strValor := TRadioGroup(WinControl.Controls[intCnt]).Items[TRadioGroup(WinControl.Controls[intCnt]).ItemIndex];
        pGravarSugestoesNoBanco(strChave, strValor, blnGravaOperadorLogado);
      End;
    End
    Else If (WinControl.Controls[intCnt] Is TGroupBox) And (TGroupBox(WinControl.Controls[intCnt]).Visible) Then
      pGravaChaveEValorSugestao(TGroupBox(WinControl.Controls[intCnt]))

    Else If (WinControl.Controls[intCnt] Is TPanel) And (TPanel(WinControl.Controls[intCnt]).Visible) Then
      pGravaChaveEValorSugestao(TPanel(WinControl.Controls[intCnt]))

    Else If (WinControl.Controls[intCnt] Is TComboBoxFocus) Then
    Begin
      If TComboBoxFocus(WinControl.Controls[intCnt]).Visible Then
      Begin
        strChave := TComboBoxFocus(WinControl.Controls[intCnt]).Name;
        strValor := TComboBoxFocus(WinControl.Controls[intCnt]).Items[TComboBoxFocus(WinControl.Controls[intCnt]).ItemIndex];
        pGravarSugestoesNoBanco(strChave, strValor, blnGravaOperadorLogado);
      End;
    End
    Else If (WinControl.Controls[intCnt] Is TcxImageComboBox) Then
    Begin
      If TcxImageComboBox(WinControl.Controls[intCnt]).Visible Then
      Begin
        strChave := TcxImageComboBox(WinControl.Controls[intCnt]).Name;
        strValor := IntToStr(TcxImageComboBox(WinControl.Controls[intCnt]).ItemIndex);
        pGravarSugestoesNoBanco(strChave, strValor, blnGravaOperadorLogado);
      End;
    End
    Else If (WinControl.Controls[intCnt] Is TcxCheckListBox) Then
    Begin
      cxCheckList := (WinControl.Controls[intCnt] As TcxCheckListBox);

      If cxCheckList.Visible Then
      Begin
        strValor := '';

        For intIdx := 0 To Pred(cxCheckList.Items.Count) Do
        Begin
          If cxCheckList.Items[intIdx].Checked Then
            strValor := strValor + cxCheckList.Items[intIdx].Text + sLineBreak;
        End;

        strChave := cxCheckList.Name;
        pGravarSugestoesNoBanco(strChave, strValor, blnGravaOperadorLogado);
      End;
    End
    Else If (WinControl.Controls[intCnt] Is TRadioButton) And (WinControl Is TGroupBox) And (WinControl.Visible) Then
    Begin
      If (TRadioButton(WinControl.Controls[intCnt]).Checked) Then
      Begin
        strChave := WinControl.Name;
        strValor := TRadioButton(WinControl.Controls[intCnt]).name;
        pGravarSugestoesNoBanco(strChave, strValor, blnGravaOperadorLogado);
      End;
    End;
  End;
end;

class procedure TCfgSugExp.pRemoverEventoControls(const WinControl: TWinControl;
  const stlNomeComponentesExcecao: TStrings);
  Var
    intCnt : Integer;
begin
  For intCnt := 0 To WinControl.ControlCount-1 Do
  Begin
    If Assigned(stlNomeComponentesExcecao) Then
    Begin
      If (stlNomeComponentesExcecao.IndexOf(WinControl.Controls[intCnt].Name) >= 0) Then
        Continue;
    End;

    If (WinControl.Controls[intCnt] Is TRadioGroup) Then
      TRadioGroup(WinControl.Controls[intCnt]).OnClick := Nil

    Else If (WinControl.Controls[intCnt] Is TGroupBox) And (TGroupBox(WinControl.Controls[intCnt]).Visible) Then
      pRemoverEventoControls(TGroupBox(WinControl.Controls[intCnt]), stlNomeComponentesExcecao)

    Else If (WinControl.Controls[intCnt] Is TPanel) And (TPanel(WinControl.Controls[intCnt]).Visible) Then
      pRemoverEventoControls(TPanel(WinControl.Controls[intCnt]), stlNomeComponentesExcecao)

    Else If (WinControl.Controls[intCnt] Is TComboBoxFocus) Then
      TComboBoxFocus(WinControl.Controls[intCnt]).OnClick := Nil

    Else If (WinControl.Controls[intCnt] Is TcxImageComboBox) Then
      TcxImageComboBox(WinControl.Controls[intCnt]).OnClick := Nil

    Else If (WinControl.Controls[intCnt] Is TcxCheckListBox) Then
      TcxCheckListBox(WinControl.Controls[intCnt]).OnClickCheck := Nil

    Else If (WinControl.Controls[intCnt] Is TEditFocus) Then
    begin
      TEditFocus(WinControl.Controls[intCnt]).OnKeyPress := Nil;
      TEditFocus(WinControl.Controls[intCnt]).OnExit     := Nil;
      TEditFocus(WinControl.Controls[intCnt]).OnChange   := Nil;
    end;
  End;
end;

end.
