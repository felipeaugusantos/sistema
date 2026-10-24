unit untArquivosExportar;

interface

Uses CheckLst, untConstantes;

Type
  TArquivosExportar = class
  private
    FchkLstItensExportar: TCheckListBox;
    FItens: Array of TBooleanFunction;

    FPosR13: Integer;

    procedure SetchkLstItensExportar(const Value: TCheckListBox);
    function GetItens(index: Integer): TBooleanFunction;
    procedure SetItens(index: Integer;
      const Value: TBooleanFunction);
    function GetCount: Integer;
  public
    constructor Create(chkLstItensExportar: TCheckListBox);

    function fAdicionarItem(strTexto: String; funcao: TBooleanFunction;
              blnMarcado: Boolean; blnSetaRegistro13: Boolean = False): Boolean;

    function fGerarArquivos: Boolean;

    property chkLstItensExportar: TCheckListBox read FchkLstItensExportar write SetchkLstItensExportar;
    property Itens[index: Integer]: TBooleanFunction read GetItens write SetItens;
    property Count: Integer read GetCount;
    property intPosR13: Integer read FPosR13 write FPosR13;

  End;


implementation


{ TArquivosExportar }

constructor TArquivosExportar.Create(chkLstItensExportar: TCheckListBox);
begin
  FchkLstItensExportar := chkLstItensExportar;
  FchkLstItensExportar.Clear;
  SetLength(FItens, 0);
end;

function TArquivosExportar.fAdicionarItem(strTexto: String;
  funcao: TBooleanFunction; blnMarcado: Boolean; blnSetaRegistro13: Boolean = False): Boolean;
begin
  Result := True;
  Try
    SetLength(FItens, Length(FItens) + 1);
    FItens[Length(FItens) - 1] := funcao;
    FchkLstItensExportar.Items.Add(strTexto);
    FchkLstItensExportar.Checked[Length(FItens) - 1] := blnMarcado;

    If blnSetaRegistro13 Then
      FPosR13 := Length(FItens) - 1;

  Except
    Result := False;
  End;
end;

function TArquivosExportar.fGerarArquivos: Boolean;
  Var
    intCont: Integer;
begin
  Result := True;

  FchkLstItensExportar.Enabled := False;

  For intCont := Low(FItens) To High(FItens) Do
  Begin
    FchkLstItensExportar.ItemIndex := intCont;
    If Result And FchkLstItensExportar.Checked[intCont] And Assigned(FItens[intCont]) Then
      Result := FItens[intCont]();
  End;

  FchkLstItensExportar.Enabled := True;
end;

function TArquivosExportar.GetCount: Integer;
begin
  Result := Length(FItens);
end;

function TArquivosExportar.GetItens(
  index: Integer): TBooleanFunction;
begin
  Result := FItens[index];
end;

procedure TArquivosExportar.SetchkLstItensExportar(
  const Value: TCheckListBox);
begin
  FchkLstItensExportar := Value;
end;

procedure TArquivosExportar.SetItens(index: Integer;
  const Value: TBooleanFunction);
begin
  FItens[index] := Value;
end;


end.
