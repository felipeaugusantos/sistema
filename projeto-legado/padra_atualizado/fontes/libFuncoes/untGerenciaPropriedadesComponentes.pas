(********************************************************************************************
OBSERVAÇÔES IMPORTANTES:

  Para a classe poder recuperar o(s) componentes é preciso fazer o registro da class
  Ex:
    initialization                     Finalization
      RegisterClass(TLabel);             UnregisterClass(TLabel);

  Nesta classe coloquei algumas
     TLabel, TPanel, TEdit, TForm, TEditFocus

  Mas se por exemplo quisermos usar um form inteiro tera que registrar a classe do Form
---------------------------------------------------------------------------------------------
USO DA CLASSE:

    constructor Create(objContainer: TComponent; strChave: String);
    objContainer: Esta variavel é o container dos componentes para os components dentro dele
                 Ex Painel, Formulario.
    strChave    : Campo CFGCON.CFG_CHAVE_

    function StringToComponent(Value: string; objComponent: TComponent): TComponent;
    Value       : O binario do componente em forma de leitura humana do component armazenado
    objComponent: O Componente a ser atualizado, cujo, mesmo será atualizado as propriedades
                e devolvida nesta chamada
    Result      : O Component atualizado;

    function ComponentToString(Component: TComponent): string;
    Component  : Component a ser armazenado
    Result     : O Texto em forma Leitura Humana do Component;

    procedure pCarregar; Carrega os componentes salvos
              e Atualiza o componentes solicitados para serem atualizados

    procedure pSalvar
              Salva os componentes no banco


    procedure pAddComponente(objComponent: TComponent);
    objComponent: o componente que sera controlado
    se passado o container não precisa passar os demais pois não tera efeito
    mas se quiser manipular apenas alguns basta alimentar esta lista
*******************************************************************************************)

unit untGerenciaPropriedadesComponentes;

interface

uses System.SysUtils, Classes, Uni, untFuncoesGen, untFuncoesSimples, vcl.ComCtrls, ExtCtrls, StdCtrls, RTTI, DAta.DB, Forms, EditFocus, Vcl.Controls, Dialogs;

Type
  TGerenciaPropriedadesComponentes = Class
  private
    FqryInterna: TUniQuery;
    FComponent: TComponent;
    FArquivo: TStringStream;
    FArquivoTMP: TStringList;
    FListaCompEspecifico: TStringList;
    blnPorOperador: Boolean;
    FstrChave: String;
    FStrCodOpe: String;
    strCampoComponente: string;
    procedure pEscreverArquivoDeComponentes;
    function  fLerArquivo(objComponentName: String;blnManterPosicao: Boolean = False): TComponent;
    function  pCarregarComponentText(strNomeComponent: String): String;
  protected
    function StringToComponent(Value: string; objComponent: TComponent): TComponent;
    function ComponentToString(Component: TComponent): string;
  public
    constructor Create(objContainer: TComponent; strChave: String); overload;
    constructor Create(objContainer: TComponent; strChave: String; strCodOpe: String); overload;
    Destructor Destroy;override;

    procedure pCarregar(blnManterPosicao: Boolean = False);
    procedure pSalvar;
    procedure pAddComponente(objComponent: TComponent);
End;

implementation

{ TGerenciaPropriedadesComponentes }


procedure TGerenciaPropriedadesComponentes.pAddComponente(
  objComponent: TComponent);
begin
  FListaCompEspecifico.Add(objComponent.Name);
end;

constructor TGerenciaPropriedadesComponentes.Create(objContainer: TComponent; strChave: String);
begin
  FComponent := objContainer;
  blnPorOperador := False;
  FqryInterna := fCriaQuery(nil);
  FArquivo := TStringStream.Create;
  FListaCompEspecifico := TStringList.Create;
  FArquivoTMP := TStringList.Create;
  FqryInterna.Sql.Add('SELECT C.* FROM CFGCON C');
  FqryInterna.Sql.Add('INNER JOIN CFGEMP E ON E.CFG_CODEMP = :CODEMP AND E.CFG_SEQGER = C.AUTOINCREM');
  FqryInterna.Sql.Add('WHERE C.CFG_CHAVE_ = :CHAVE_  ');

  strCampoComponente := 'CFG_PROCON';

  FqryInterna.ParamByName('CHAVE_').AsString := strChave;
  FqryInterna.ParamByName('CODEMP').AsString := VS_StrCodEmp;
  FstrChave := strChave;
  FStrCodOpe := '';
  FqryInterna.Open;

  If Not FqryInterna.IsEmpty Then
    FArquivoTMP.Text := fLinhaToTexto(FqryInterna.FieldByName(strCampoComponente).AsString);

  inherited Create;
end;

constructor TGerenciaPropriedadesComponentes.Create(objContainer: TComponent; strChave: String; strCodOpe: String);
begin

  FComponent := objContainer;

  strCampoComponente := 'PRO_PROCOM';
  blnPorOperador := False;
  FqryInterna :=  fCriaQuery;
  FArquivo := TStringStream.Create;
  FListaCompEspecifico := TStringList.Create;
  FArquivoTMP := TStringList.Create;
  FqryInterna.Sql.Add('SELECT C.* FROM PROPCO C');
  FqryInterna.Sql.Add('WHERE C.PRO_CHAVE_ = :CHAVE_  ');
  FqryInterna.Sql.Add('  AND C.PRO_CODOPE = :CODOPE ');


  FqryInterna.ParamByName('CHAVE_').AsString := strChave;
  FqryInterna.ParamByName('CODOPE').AsString := strCodOpe;

  FstrChave := strChave;
  FStrCodOpe := strCodOpe;
  blnPorOperador := True;

  Try
    FqryInterna.Open;
  Except
    on e: exception do
      Showmessage(e.message)
  End;

  If Not FqryInterna.IsEmpty Then
    FArquivoTMP.Text := fLinhaToTexto(FqryInterna.FieldByName(strCampoComponente).AsString);

  inherited Create;
End;

procedure TGerenciaPropriedadesComponentes.pCarregar(blnManterPosicao: Boolean = False);
  var
    I: Integer;
  procedure pProcessa(objComponent: TComponent; blnManterPosicao: Boolean = False);
  begin
    If Assigned(objComponent) Then
      fLerArquivo(objComponent.Name, blnManterPosicao);
  End;

begin
  If FListaCompEspecifico.Count > 0 Then
  Begin
    For i := 0 To FListaCompEspecifico.Count -1 Do
    Begin
      If FComponent.Name = FListaCompEspecifico[i] Then
        pProcessa(FComponent, blnManterPosicao)
      Else
        pProcessa(FComponent.FindComponent(FListaCompEspecifico[i]), blnManterPosicao);
    End;
  End
  Else
  Begin
    For i := 0 To FComponent.ComponentCount - 1 Do
      pProcessa(FComponent.Components[i])
  End;
end;

Function TGerenciaPropriedadesComponentes.fLerArquivo(objComponentName: String;blnManterPosicao: Boolean = False): TComponent;
  var strComponent: String;
      objComponent: TComponent;
      Top, Left: Integer;
begin
  Result := Nil;
  Top  := 0;
  Left := 0;

  If objComponentName <> '' Then
  Try
    strComponent := pCarregarComponentText(objComponentName);
    If strComponent <> '' Then
    Begin
      If FComponent.Name = objComponentName Then
         objComponent := FComponent
      Else
        objComponent := FComponent.FindComponent(objComponentName);
      If Assigned(objComponent) Then
      Begin
        If blnManterPosicao Then
        Begin
          If (objComponent is TLabel) or
             (objComponent is TPanel) or
             (objComponent is TEdit) or
             (objComponent is TEditFocus) Or
             (objComponent is TSplitter) Or
             (objComponent is TComboBox) Then
          Begin
            Top := TControl(objComponent).Top;
            Left:= TControl(objComponent).Left;
          End;
        End;

        Result := StringToComponent(strComponent, objComponent);
        If blnManterPosicao Then
        Begin
          If (objComponent is TLabel) or
             (objComponent is TPanel) or
             (objComponent is TEdit) or
             (objComponent is TEditFocus) Or
             (objComponent is TComboBox) Or
             (objComponent is TSplitter) Then
          Begin
            TControl(objComponent).Top := Top;
            TControl(objComponent).Left := Left;

          End;
        End;
      End;
    End;
  Except
    { Situações:
          - Escrita do Arquivo inválida ou não encontrada
          - Component não encontrado no container
          - Classe não Registrada}

  End;
end;

procedure TGerenciaPropriedadesComponentes.pSalvar;
begin
  Try
    If Not blnPorOperador Then
    Begin
      If FqryInterna.IsEmpty Then
         Exit;

      //Inicia a Criação do arquivo
      pEscreverArquivoDeComponentes;
      FqryInterna.Edit;
      FqryInterna.FieldByName(strCampoComponente).Value := fTextoToLinha(FArquivo.DataString);
      FqryInterna.Post;
    End
    Else
    Begin
      pEscreverArquivoDeComponentes;
      If FqryInterna.IsEmpty Then
      begin
        FqryInterna.Insert;
        FqryInterna.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PROPCO', VS_StrCodEmp);
        FqryInterna.FieldByName('PRO_CODOPE').AsString := FStrCodOpe;
        FqryInterna.FieldByName('PRO_CHAVE_').AsString := FstrChave;
      End
      Else
        FqryInterna.Edit;

      FqryInterna.FieldByName('PRO_PROCOM').AsString := fTextoToLinha(FArquivo.DataString);

      FqryInterna.Post;
    End;
  Except
  End;
end;

function TGerenciaPropriedadesComponentes.pCarregarComponentText(strNomeComponent: String): String;
  Var intPos: Integer;
begin
  intPos :=  FArquivoTMP.IndexOf(strNomeComponent);
  If IntPos > -1 Then
  Begin
    Inc(intPos, 1);
    While not (FArquivoTMP[intPos] = '[FIM]') Do
    begin
      Result := Result + FArquivoTMP[intPos];
      Result := Result + #$D#$A;
      Inc(intPos);
    End;
  End;
end;

procedure TGerenciaPropriedadesComponentes.pEscreverArquivoDeComponentes;
  Var
    intCont: integer;
  procedure pEscreve(objComponent: TComponent);
  Begin
    If Assigned(objComponent) Then
    Begin
      FArquivo.WriteString(objComponent.Name);
      FArquivo.WriteString(#$D#$A);
      FArquivo.WriteString(ComponentToString(objComponent));
      FArquivo.WriteString('[FIM]' + #$D#$A);
    End;
  End;
Begin
  If FListaCompEspecifico.Count <> 0 Then
  Begin
    For IntCont := 0 To FListaCompEspecifico.Count -1 Do
    Begin
      If FComponent.Name = FListaCompEspecifico[IntCont] Then
        pEscreve(FComponent)
      Else
        pEscreve(FComponent.FindComponent(FListaCompEspecifico.Strings[intCont]));
    End;
  End
  Else
  Begin
    For intCont := 0 To FComponent.ComponentCount -1 Do
      pEscreve(FComponent.Components[intCont]);
  End;
End;

destructor TGerenciaPropriedadesComponentes.Destroy;
begin
  FreeAndNil(FqryInterna);
  FreeAndNil(FArquivo);
  FreeAndNil(FListaCompEspecifico);
  FreeAndNil(FArquivoTMP);
  inherited Destroy;
end;

function TGerenciaPropriedadesComponentes.ComponentToString(Component: TComponent): string;
var
  BinStream:TMemoryStream;
  StrStream: TStringStream;
  s: String;
begin
  BinStream := TMemoryStream.Create;
  try
    StrStream := TStringStream.Create(s);
    try
      BinStream.WriteComponent(Component);
      BinStream.Seek(0, soFromBeginning);
      ObjectBinaryToText(BinStream, StrStream);
      StrStream.Seek(0, soFromBeginning);
      Result:= StrStream.DataString;
    finally
      StrStream.Free;
    end;
  finally
    BinStream.Free;
  end;
end;

function TGerenciaPropriedadesComponentes.StringToComponent(Value: string; objComponent: TComponent): TComponent;
var
  StrStream:TStringStream;
  BinStream: TMemoryStream;
begin
  Result := Nil;
  StrStream := TStringStream.Create(Value);
  try
    BinStream := TMemoryStream.Create;
    try
      ObjectTextToBinary(StrStream, BinStream);
      BinStream.Seek(0, soFromBeginning);
      If objComponent Is TForm Then
        TForm(objComponent).DestroyComponents;
      Try
         Result:= BinStream.ReadComponent(objComponent);
      Except
         {Objeto não registrado ou stream inválido}
      End;
    finally
      BinStream.Free;
    end;
  finally
    StrStream.Free;
  end;
end;


initialization
  RegisterClass(TLabel);
  RegisterClass(TPanel);
  RegisterClass(TEdit);
  RegisterClass(TForm);
  RegisterClass(TEditFocus);
  RegisterClass(TComboBox);
  RegisterClass(TSplitter);
  RegisterClass(TListBox);

Finalization
  UnregisterClass(TLabel);
  UnregisterClass(TPanel);
  UnregisterClass(TEdit);
  UnregisterClass(TForm);
  UnregisterClass(TEditFocus);
  UnregisterClass(TComboBox);
  UnregisterClass(TSplitter);
  UnregisterClass(TListBox);

end.

