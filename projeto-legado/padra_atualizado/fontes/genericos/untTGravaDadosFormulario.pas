unit untTGravaDadosFormulario;

interface

  uses SysUtils,Classes, Forms, EditFocus, uni, StdCtrls, untFuncoesSimples,
       ExtCtrls, MaskEditFocus, ComboBoxFocus, data.DB, UniClientDataSet, Vcl.Controls, Datasnap.DBClient;

  type
    TGetDadosExtras = procedure(var AStringList: TStringList) of object;

    TGravaDadosFormulario = class
    protected
      qryComand: TUniQuery;
      stlConteudo: TStringList;
      procedure pEscreveConteudoEditFocus(Component: TComponent);
      procedure pEscreveConteudoRadioGroup(Component: TComponent);
      procedure pEscreveConteudoMaskEditFocus(Component: TComponent);
      procedure pEscreveConteudoComboBoxFocus(Component: TComponent);
      procedure pEscreveConteudoCheckBox(Component: TComponent);
      procedure pEscreveConteudoUniClientDataSet(Control: TComponent);
      procedure pPersisteDados(frmSelf: TForm);

    public
      class procedure pExecutaGravacao(frmSelf: TForm; OnGetDadosExtras: TGetDadosExtras = nil);
      constructor Create(AOwner: TComponent);
      destructor Destroy; override;

    end;

implementation

{ TGravaDadosFormulario }

constructor TGravaDadosFormulario.Create(AOwner: TComponent);
begin
  qryComand := fCriaQuery;
  stlConteudo := TStringList.Create;
end;

destructor TGravaDadosFormulario.Destroy;
begin
  FreeAndNil(qryComand);
  FreeAndNil(stlConteudo);
  inherited;
end;

procedure TGravaDadosFormulario.pEscreveConteudoCheckBox(Component: TComponent);
begin
    If Component is TComboBoxFocus Then
    stlConteudo.Add(Component.Name + '=' + IIf(TCheckBox(Component).Checked, '1', '0'));
end;

procedure TGravaDadosFormulario.pEscreveConteudoComboBoxFocus(
  Component: TComponent);
begin
    If Component is TComboBoxFocus Then
    stlConteudo.Add(Component.Name + '=' + TComboBoxFocus(Component).Text)
end;

procedure TGravaDadosFormulario.pEscreveConteudoEditFocus(Component: TComponent);
begin
  If Component is TEditFocus then
    stlConteudo.Add(Component.Name + '=' + TEditFocus(Component).Text)
end;


procedure TGravaDadosFormulario.pEscreveConteudoMaskEditFocus(
  Component: TComponent);
begin
  If Component is TMaskEditFocus then
    stlConteudo.Add(Component.Name + '=' + TMaskEditFocus(Component).Text)
end;

procedure TGravaDadosFormulario.pEscreveConteudoRadioGroup(
  Component: TComponent);
begin
  If Component is TRadioGroup then
    stlConteudo.Add(Component.Name + '=' + TRadioGroup(Component).ItemIndex.ToString)

end;

procedure TGravaDadosFormulario.pEscreveConteudoUniClientDataSet(
  Control: TComponent);
var StringStream: TStringStream;
begin
  if Not (Control is TUniClientDataSet) then
    Exit;
  StringStream := TStringStream.Create;
  TUniClientDataSet(Control).SaveToStream(StringStream, dfXMLUTF8);
  stlConteudo.Add(TUniClientDataSet(Control).Name +'='+ StringStream.DataString)
end;

class procedure TGravaDadosFormulario.pExecutaGravacao(frmSelf: TForm;
  OnGetDadosExtras: TGetDadosExtras);
var GravaDadosFormulario : TGravaDadosFormulario;
    i: integer;
begin
  GravaDadosFormulario := TGravaDadosFormulario.Create(nil);
  Try
    If Assigned(OnGetDadosExtras) Then
      OnGetDadosExtras(GravaDadosFormulario.stlConteudo);
    for i :=0  To frmSelf.ComponentCount -1 do
    Begin
      GravaDadosFormulario.pEscreveConteudoEditFocus(frmSelf.Components[i]);
      GravaDadosFormulario.pEscreveConteudoRadioGroup(frmSelf.Components[i]);
      GravaDadosFormulario.pEscreveConteudoMaskEditFocus(frmSelf.Components[i]);
      GravaDadosFormulario.pEscreveConteudoComboBoxFocus(frmSelf.Components[i]);
      GravaDadosFormulario.pEscreveConteudoCheckBox(frmSelf.Components[i]);
//      GravaDadosFormulario.pEscreveConteudoUniClientDataSet(frmSelf.Components[i])
    End;

    If Not fEmptyStr(GravaDadosFormulario.stlConteudo.Text) Then
       GravaDadosFormulario.pPersisteDados(frmSelf);
  Finally
    FreeAndNil(GravaDadosFormulario);
  End;

end;

procedure TGravaDadosFormulario.pPersisteDados(frmSelf: TForm);

begin
  qryComand.SQl.Add('SELECT * FROM PARFRM WHERE FALSE');
  qryComand.Open;
  qryComand.Insert;

  qryComand.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PARFRM', VS_strCodEmp);
  qryComand.FieldByName('FRM_DTAHOR').AsDateTime := fNow;
  qryComand.FieldByName('FRM_NOMFRM').AsString := frmSelf.Name;
  qryComand.FieldByName('FMR_CONTEU').AsString := stlConteudo.Text;
  qryComand.FieldByName('FRM_CODOPE').AsString := strLoginUsuarioLogado;


  qryComand.Post;
end;

end.
