unit untLibDominioSistemasFuncoes;

interface

uses
  untLibDominioSistemasInterfacesTipos, System.Classes, System.SysUtils,
  System.StrUtils, Vcl.Forms, Vcl.Themes, Vcl.Styles, Vcl.SysStyles ;

Type
  TLibDominioSistemasFuncoes = class
  public
    class function AguardeExecutarModalA(const AGenericProcedure: TGenericProcedure;
                                         const ADescricaoTela,
                                         AChaveTela: string): Boolean;
    class function ExecutaAguarde(AFuncaoGravando: TFunctionFormGravando;
                                  AMensagem: String): Boolean;
    class procedure pCriarFormularios(Classe: TComponentClass; Var frmForm);
    class procedure CarregaEstiloAutcom;
  end ;

var
  VS_AutcomModoClassico: Boolean;

const
  AUTCOM_STYLE_NAME = 'Sapphire Kamri';

implementation

uses
  untDominioSistemasFuncoes, untLibCartoesGravando,
  untLibCartoesGravandoOld ;

{ TLibDominioSistemasFuncoes }

class function TLibDominioSistemasFuncoes.AguardeExecutarModalA(
  const AGenericProcedure: TGenericProcedure; const ADescricaoTela,
  AChaveTela: string): Boolean;
begin
  If VS_FuncoesExternas.fITelaGravandoAntiga Then
    Result := TfrmGravandoOld.fExecutarModalA(AGenericProcedure, ADescricaoTela, AChaveTela)
  Else
    Result := TfrmGravando.fExecutarModalA(AGenericProcedure, ADescricaoTela, AChaveTela);
end;

class procedure TLibDominioSistemasFuncoes.CarregaEstiloAutcom;
begin
  If VS_AutcomModoClassico Then
    Exit;

  Try
    TStyleManager.TrySetStyle(AUTCOM_STYLE_NAME);
    TStyleManager.SystemHooks  := TStyleManager.SystemHooks - [shDialogs];

    TCustomStyleEngine.UnRegisterSysStyleHook('#32768', TSysPopupStyleHook);

    TCustomStyleEngine.UnRegisterSysStyleHook('#32770', TSysDialogStyleHook);

    TCustomStyleEngine.UnRegisterSysStyleHook('ScrollBar', TSysScrollBarStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('Button', TSysButtonStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('Edit', TSysEditStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('ComboBox', TSysComboBoxStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('Label', TSysComboBoxStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('ListBox', TSysListBoxStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('ComboLBox', TSysListBoxStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('Static', TSysStaticStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('Shape', TSysStaticStyleHook);

    TCustomStyleEngine.UnRegisterSysStyleHook('ToolbarWindow32', TSysToolbarStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('SysListView32', TSysListViewStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('SysTabControl32', TSysTabControlStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('SysTreeView32', TSysTreeViewStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('msctls_progress32', TSysProgressBarStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit20A', TSysRichEditStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit20W', TSysRichEditStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit30A', TSysRichEditStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit30W', TSysRichEditStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit41A', TSysRichEditStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit41W', TSysRichEditStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit50A', TSysRichEditStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit50W', TSysRichEditStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('RebarWindow32', TSysReBarStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('msctls_statusbar32', TSysStatusBarStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('msctls_trackbar32', TSysTrackBarStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('msctls_updown32', TSysUpDownStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('tooltips_class32', TSysTooltipsStyleHook);
  Except
    VS_AutcomModoClassico := True;
  End;
end;

class function TLibDominioSistemasFuncoes.ExecutaAguarde(
  AFuncaoGravando: TFunctionFormGravando; AMensagem: String): Boolean;
Var
  LFormGravandoOld: TfrmGravandoOld;

  LFormGravando: TfrmGravando;
Begin
  If VS_FuncoesExternas.fITelaGravandoAntiga Then
  Begin
    Try
      pCriarFormularios(TfrmGravandoOld, LFormGravandoOld);
      LFormGravandoOld.fExecutarAcao := AFuncaoGravando;
      LFormGravandoOld.lblGravando.Caption := AMensagem;
      LFormGravandoOld.pgbStatus.Visible := True;
      LFormGravandoOld.ShowModal;

      Exit(LFormGravandoOld.blnConfirma);
    Finally
      FreeAndNil(LFormGravandoOld);
    End;
  End;

  Try
    pCriarFormularios(TfrmGravando, LFormGravando);
    LFormGravando.fExecutarAcao := AFuncaoGravando;
    LFormGravando.lblGravando.Caption := AMensagem;
    LFormGravando.pgbStatus.Visible := True;
    LFormGravando.ShowModal;

    Result := LFormGravando.blnConfirma;
  Finally
    FreeAndNil(LFormGravando);
  End;
end;

class procedure TLibDominioSistemasFuncoes.pCriarFormularios(
  Classe: TComponentClass; var frmForm);
Var
  intCont: Integer;
  strMsg: String;
Begin

  strMsg := '';

  For intCont := 0 To 4 Do
  Begin

    Try
      Application.CreateForm(Classe, frmForm);
      strMsg := '';
    Except
      On E: EAccessViolation Do
        Raise;

      On E: Exception Do
        strMsg := E.Message + ' ' + E.ClassName;
    End;

    If Trim(strMsg).IsEmpty Then
      Break;

    Application.ProcessMessages;
    Sleep(1500);

  End;

  If Not Trim(strMsg).IsEmpty Then
    Raise Exception.Create('Erro ao criar o formulário.' + #13 + strMsg);
end;

end.
