unit untFrmDir;

interface

uses Vcl.Forms, Vcl.StdCtrls, System.Classes, System.SysUtils, Uni, Vcl.Menus, System.Generics.Collections,
  System.TypInfo, untTypesSistema, Data.DB, System.DateUtils;

Type
  TRegistrarFormPermissaoAcesso = class(TInterfacedObject, IRegistrarFormPermissaoAcesso)
  private type
    TFormInfo = (fiName, fiCaption);
  private
    FCreatedOrder: Integer;
    FProject: String;
    FEnabled: Boolean;
    FMainMenu: TMainMenu;
    FForms: TDictionary<Integer, TForm>;
  private
    function GetFormularios(AFormInfo: TFormInfo): String;
    function FormNaoPermitido(AForm: TForm): Boolean;
    function ValidarForm(AForm: TForm): Boolean;
    function GetFormCaption(AForm: TForm): String;
    procedure GravarTabelaFormDireitoAcesso(ADirAce: String);
  public
    constructor Create(AProject: String);
    destructor Destroy; override;
    function GetDescricaoDirAce(ADirAce: String): String;
    function RegistrarDireitosAcesso(ADirAce: String): IRegistrarFormPermissaoAcesso;
    function Enabled(): Boolean; overload;
    function Enabled(AValue: Boolean): IRegistrarFormPermissaoAcesso; overload;
    function MainMenu(AValue: TMainMenu): IRegistrarFormPermissaoAcesso;
    function AddForm(AForm: TForm): IRegistrarFormPermissaoAcesso;
    function RemoveForm(AForm: TForm): IRegistrarFormPermissaoAcesso;
  end;

implementation

uses
  untFuncoesSimples;

{ TRegistrarFormPermissaoAcesso }

function TRegistrarFormPermissaoAcesso.AddForm(AForm: TForm): IRegistrarFormPermissaoAcesso;
begin
  Result := Self;
  Inc(FCreatedOrder);
  FForms.Add(FCreatedOrder, AForm);
end;

constructor TRegistrarFormPermissaoAcesso.Create(AProject: String);
begin
  FProject := AProject;
  FCreatedOrder := 0;
  FEnabled := False;
  FForms := TDictionary<Integer, TForm>.Create;
end;

function TRegistrarFormPermissaoAcesso.FormNaoPermitido(AForm: TForm): Boolean;
begin
  If String(AForm.Name).ToLower.Contains('frmPrincipal'.ToLower) Then
    Exit(True);

  If String(AForm.Name).ToLower.Contains('frmGravando'.ToLower) Then
    Exit(True);

  If String(AForm.Name).ToLower.Contains('frmFatLiberacaoCliente'.ToLower) Then
    Exit(True);

  Result := False;
end;

destructor TRegistrarFormPermissaoAcesso.Destroy;
begin
  FForms.Destroy;
  inherited;
end;

function TRegistrarFormPermissaoAcesso.Enabled: Boolean;
begin
  Result := FEnabled;
end;

function TRegistrarFormPermissaoAcesso.Enabled(AValue: Boolean): IRegistrarFormPermissaoAcesso;
begin
  Result := Self;
  FEnabled := AValue;
end;

function TRegistrarFormPermissaoAcesso.GetDescricaoDirAce(ADirAce: String): String;
Var
  LMenu: TMenuItem;
  I: Integer;
begin
  Result := '';
  LMenu := Nil;
  For I := 0 To Pred(Self.FMainMenu.Items.Count) Do
  Begin
    LMenu := fFindMenu(ADirAce, Self.FMainMenu.Items[I], True);
    If Assigned(LMenu) Then
      Break;
  End;
  If Assigned(LMenu) Then
    Result := fGetMenuPath(LMenu);
end;

function TRegistrarFormPermissaoAcesso.GetFormCaption(AForm: TForm): String;
Var
  LPropInfo: PPropInfo;
begin
  Result := '';
  LPropInfo := GetPropInfo(AForm, 'OriginalCaption');

  If Assigned(LPropInfo) Then
    Result := GetPropValue(AForm, 'OriginalCaption');

  If Result.IsEmpty Then
    Result := AForm.Caption;

  Result := Result.Replace(VS_strTituloVersao, '');
end;

function TRegistrarFormPermissaoAcesso.GetFormularios(AFormInfo: TFormInfo): String;
Var
  LForm: TForm;
  LKey: Integer;
  LClassNames: String;
  LArray: TArray<Integer>;
begin
  Result := '';
  LClassNames := '';

  LArray := FForms.Keys.ToArray;
  TArray.Sort<Integer>(LArray);

  For LKey In LArray Do
  Begin
    If Not FForms.TryGetValue(LKey, LForm) Then
      Continue;

    If Not ValidarForm(LForm) Then
      Continue;

    If Not Result.IsEmpty Then
      Result := Result + ' > ';

    LClassNames := LClassNames + ' > ';

    If LClassNames.ToLower.Contains(String(LForm.ClassName).ToLower) Then
      Exit('');

    LClassNames := LClassNames + LForm.ClassName;

    Case AFormInfo Of
      fiName:
        Result := Result + LForm.Name;
      fiCaption:
        Result := Result + GetFormCaption(LForm);
    End;
  End;

end;

procedure TRegistrarFormPermissaoAcesso.GravarTabelaFormDireitoAcesso(ADirAce: String);
Var
  LQuery: TUniQuery;
begin
  Try
    LQuery := fCriaQuery;
    Try
      LQuery.SQL.Text := 'SELECT * FROM FRMDIR WHERE FRM_NOMMNU = :NOMMNU AND ' +
        'FRM_NOMFRM = :NOMFRM AND FRM_NOMDIR = :NOMDIR AND FRM_NOMPRO = :NOMPRO ';

      LQuery.ParamByName('NOMMNU').AsString := VS_strLastMenuName;
      LQuery.ParamByName('NOMFRM').AsString := Self.GetFormularios(fiName);
      LQuery.ParamByName('NOMDIR').AsString := ADirAce;
      LQuery.ParamByName('NOMPRO').AsString := FProject;

      LQuery.Open;

      If LQuery.IsEmpty Then
      Begin
        LQuery.Append;
        LQuery.FieldByName('AUTOINCREM').AsString := fRetAutoincrem('FRMDIR', Vs_strCodEmp);
        LQuery.FieldByName('FRM_NOMMNU').AsString := VS_strLastMenuName;
        LQuery.FieldByName('FRM_NOMFRM').AsString := Self.GetFormularios(fiName);
        LQuery.FieldByName('FRM_NOMDIR').AsString := ADirAce;
      End
      Else
      Begin
        If LQuery.FieldByName('FRM_DESMNU').AsString.Equals(VS_strLastMenuCaption) And
          LQuery.FieldByName('FRM_DESFRM').AsString.Equals(Self.GetFormularios(fiCaption)) And
          LQuery.FieldByName('FRM_DESDIR').AsString.Equals(Self.GetDescricaoDirAce(ADirAce)) Then
        Begin
          Exit;
        End;
        LQuery.Edit;
      End;

      LQuery.FieldByName('FRM_DESMNU').AsString := VS_strLastMenuCaption;
      LQuery.FieldByName('FRM_DESFRM').AsString := Self.GetFormularios(fiCaption);
      LQuery.FieldByName('FRM_DESDIR').AsString := Self.GetDescricaoDirAce(ADirAce);

      LQuery.FieldByName('FRM_NOMPRO').AsString := FProject;
      LQuery.FieldByName('FRM_ULTALT').AsDateTime := VS_Date + Time();

      LQuery.Post;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TRegistrarFormPermissaoAcesso.RegistrarDireitosAcesso]');
      End;
    End;
  Finally
    FreeAndNil(LQuery);
  End;
end;

function TRegistrarFormPermissaoAcesso.MainMenu(AValue: TMainMenu): IRegistrarFormPermissaoAcesso;
begin
  Result := Self;
  FMainMenu := AValue;
end;

function TRegistrarFormPermissaoAcesso.RegistrarDireitosAcesso(ADirAce: String)
  : IRegistrarFormPermissaoAcesso;
begin
  Result := Self;

  If Not Self.FEnabled Then
    Exit;

  If Self.GetFormularios(fiName).Equals('') Then
    Exit;

  If Self.GetFormularios(fiName).ToLower.Equals('frmPrincipal'.ToLower) Then
    Exit;

  If Self.GetDescricaoDirAce(ADirAce).IsEmpty Then
    Exit;

  GravarTabelaFormDireitoAcesso(ADirAce);
end;

function TRegistrarFormPermissaoAcesso.RemoveForm(AForm: TForm): IRegistrarFormPermissaoAcesso;
Var
  I: Integer;
  LName: String;
  LKeys: TArray<Integer>;
begin
  Result := Self;

  Try
    LKeys := FForms.Keys.ToArray;

    For I In LKeys Do
      If Assigned(FForms[I]) And Assigned(AForm) Then
      Begin
        LName := '';

        If Not FForms[I].InheritsFrom(TComponent) Then
        Begin
          FForms.Remove(I);
          Continue;
        End;

        Try
          LName := FForms[I].Name;
        Except
          FForms.Remove(I);
        End;

        If LName.IsEmpty Then
          Continue;

        Try
          If SameText(LName, AForm.Name) Then
            FForms.Remove(I);
        Except
          //do nothing
        End;
      End;
  Except
    Application.ProcessMessages;
  End;
end;

function TRegistrarFormPermissaoAcesso.ValidarForm(AForm: TForm): Boolean;
begin
  Result := True;
  Try
    If Not Assigned(AForm) Then
      Exit(False);

    If Not AForm.InheritsFrom(TComponent) Then
      Exit(False);

    If String(AForm.Name).IsEmpty Then
      Exit(False);

    If String(AForm.Caption).IsEmpty Then
      Exit(False);

    If FormNaoPermitido(AForm) Then
      Exit(False);

    If AForm.Parent <> Nil Then
      Exit(False);
  Except
    Result := False;
  End;
end;

end.
