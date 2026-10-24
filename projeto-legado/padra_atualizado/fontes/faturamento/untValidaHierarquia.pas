unit untValidaHierarquia;

interface

uses Classes, DBEditFocus, Vcl.Graphics, Vcl.Controls;

const
  clCorNormal: TColor = clWindow;
  clCorAlerta: TColor = $008080FF;

type
  TResultado = record
    TemInconsistencia : Boolean;
    Mensagem          : String;
  End;

type
  THierarquia = (hVendedorJunior = 0,
                 hVendedorMaster = 1,
                 hSubGerenJunior = 2,
                 hSubGerenMaster = 3,
                 hGerente_Junior = 4,
                 hGerente_Master = 5);

  THierarquiaHelper = record helper for THierarquia
    function getDescricao  : String;
    function getHierarquia : Integer;
  End;

type
  TItemHierarquia = record
    Valor: Double;
    Obejt: TObject;
  End;

type
  TValidaHierarquia = Class(TComponent)
  Private
    arrHierarquia : array [0..5] of TItemHierarquia;
    procedure pAjustaCorAndHntDefault(AObject: TObject);
    procedure pAjustaCor(AObject: TObject; clCor: TColor); Overload;
    procedure pAjustaHnt(AObject: TObject; strHint: String); Overload;
  Public

    Constructor Create(Owner: TComponent); Reintroduce;
    Destructor Destroy; Override;

    procedure pLimpar;
    procedure pSetVendedorJunior(AValue: Double; AObject: TObject=Nil);
    procedure pSetVendedorMaster(AValue: Double; AObject: TObject=Nil);
    procedure pSetSubGerenJunior(AValue: Double; AObject: TObject=Nil);
    procedure pSetSubGerenMaster(AValue: Double; AObject: TObject=Nil);
    procedure pSetGerente_Junior(AValue: Double; AObject: TObject=Nil);
    procedure pSetGerente_Master(AValue: Double; AObject: TObject=Nil);

    function fValidarDescontoMaximoOperador : TResultado;
    function fValidarMargemMinimaOperador   : TResultado;

  End;

implementation

Const
  DESCO = ' Desconto Máx. ';
  MARMI = ' Margem Min. ';
  MENOR = ' não pode ser Menor que ';
  MAIOR = ' não pode ser Maior que ';

{ THierarquiaHelper }

function THierarquiaHelper.getDescricao: String;
begin

  Case Self Of
    hVendedorJunior : Result := 'Vendedor Júnior';
    hVendedorMaster : Result := 'Vendedor Master';
    hSubGerenJunior : Result := 'Sub-Gerente Júnior';
    hSubGerenMaster : Result := 'Sub-Gerente Master';
    hGerente_Junior : Result := 'Gerente Júnior';
    hGerente_Master : Result := 'Gerente Master';
    Else Result := '';
  End;

end;

function THierarquiaHelper.getHierarquia: Integer;
begin

  Case Self Of
    hVendedorJunior : Result := 0;
    hVendedorMaster : Result := 1;
    hSubGerenJunior : Result := 2;
    hSubGerenMaster : Result := 3;
    hGerente_Junior : Result := 4;
    hGerente_Master : Result := 5;
    Else Result := -1;
  End

end;

{ TValidaHierarquia }

constructor TValidaHierarquia.Create(Owner: TComponent);
begin
  Inherited;
  pLimpar;
end;

destructor TValidaHierarquia.Destroy;
begin
  inherited;
end;

function TValidaHierarquia.fValidarDescontoMaximoOperador: TResultado;
var
  LPrimario,
  LSecundario : THierarquia;
  LSuperior   : Boolean;
begin

  Result.TemInconsistencia := False;
  Result.Mensagem          := '';

  For LPrimario := Low(THierarquia) To High(THierarquia) Do
    pAjustaCorAndHntDefault(arrHierarquia[LPrimario.getHierarquia].Obejt);

  For LPrimario := Low(THierarquia) To High(THierarquia) Do
  Begin

    For LSecundario := Low(THierarquia) To High(THierarquia) Do
    Begin

      If (arrHierarquia[LPrimario.getHierarquia].Valor < 0) Then
        Continue;

      If (arrHierarquia[LSecundario.getHierarquia].Valor < 0) Then
        Continue;

      LSuperior := (LPrimario.getHierarquia > LSecundario.getHierarquia);

      If LSuperior Then
      Begin
        If arrHierarquia[LPrimario.getHierarquia].Valor < arrHierarquia[LSecundario.getHierarquia].Valor Then
        Begin
          If (Not Result.TemInconsistencia) Then
          Begin
            Result.TemInconsistencia := True;
            Result.Mensagem          := DESCO + LPrimario.getDescricao + MENOR + DESCO + LSecundario.getDescricao;
          End;

          pAjustaCor(arrHierarquia[LPrimario.getHierarquia].Obejt,   clCorAlerta);
          pAjustaHnt(arrHierarquia[LPrimario.getHierarquia].Obejt,   'Atenção: Desconto Máximo menor ao informado para os subordinados hierárquicos!');
          pAjustaCor(arrHierarquia[LSecundario.getHierarquia].Obejt, clCorAlerta);
          pAjustaHnt(arrHierarquia[LSecundario.getHierarquia].Obejt, 'Atenção: Desconto Máximo maior ao informado para os superiores hierárquicos!');
        End;
      End
      Else
      Begin
        If arrHierarquia[LPrimario.getHierarquia].Valor > arrHierarquia[LSecundario.getHierarquia].Valor Then
        Begin
          If (Not Result.TemInconsistencia) Then
          Begin
            Result.TemInconsistencia := True;
            Result.Mensagem          := DESCO + LPrimario.getDescricao + MAIOR + DESCO + LSecundario.getDescricao;
          End;

          pAjustaCor(arrHierarquia[LPrimario.getHierarquia].Obejt,   clCorAlerta);
          pAjustaHnt(arrHierarquia[LPrimario.getHierarquia].Obejt,   'Atenção: Desconto Máximo maior ao informado para os superiores hierárquicos!');
          pAjustaCor(arrHierarquia[LSecundario.getHierarquia].Obejt, clCorAlerta);
          pAjustaHnt(arrHierarquia[LSecundario.getHierarquia].Obejt, 'Atenção: Desconto Máximo menor ao informado para os subordinados hierárquicos!');
        End;
      End;

    End;

  End;

end;

function TValidaHierarquia.fValidarMargemMinimaOperador: TResultado;
var
  LPrimario,
  LSecundario : THierarquia;
  LSuperior   : Boolean;
begin

  Result.TemInconsistencia := False;
  Result.Mensagem          := '';

  For LPrimario := Low(THierarquia) To High(THierarquia) Do
    pAjustaCorAndHntDefault(arrHierarquia[LPrimario.getHierarquia].Obejt);

  For LPrimario := Low(THierarquia) To High(THierarquia) Do
  Begin

    For LSecundario := Low(THierarquia) To High(THierarquia) Do
    Begin

      If (arrHierarquia[LPrimario.getHierarquia].Valor < 0) Then
        Continue;

      If (arrHierarquia[LSecundario.getHierarquia].Valor < 0) Then
        Continue;

      LSuperior := (LPrimario.getHierarquia > LSecundario.getHierarquia);

      If LSuperior Then
      Begin
        If arrHierarquia[LPrimario.getHierarquia].Valor > arrHierarquia[LSecundario.getHierarquia].Valor Then
        Begin
          If (Not Result.TemInconsistencia) Then
          Begin
            Result.TemInconsistencia := True;
            Result.Mensagem          := MARMI + LPrimario.getDescricao + MAIOR + MARMI + LSecundario.getDescricao;
          End;

          pAjustaCor(arrHierarquia[LPrimario.getHierarquia].Obejt,   clCorAlerta);
          pAjustaHnt(arrHierarquia[LPrimario.getHierarquia].Obejt,   'Atenção: Margem Mínima maior a informada para os subordinados hierárquicos!');
          pAjustaCor(arrHierarquia[LSecundario.getHierarquia].Obejt, clCorAlerta);
          pAjustaHnt(arrHierarquia[LSecundario.getHierarquia].Obejt, 'Atenção: Margem Mínima menor a informada para os superiores hierárquicos!');
        End;
      End
      Else
      Begin
        If arrHierarquia[LPrimario.getHierarquia].Valor < arrHierarquia[LSecundario.getHierarquia].Valor Then
        Begin
          If (Not Result.TemInconsistencia) Then
          Begin
           Result.TemInconsistencia := True;
           Result.Mensagem          := MARMI + LPrimario.getDescricao + MENOR + MARMI + LSecundario.getDescricao;
          End;

          pAjustaCor(arrHierarquia[LPrimario.getHierarquia].Obejt,   clCorAlerta);
          pAjustaHnt(arrHierarquia[LPrimario.getHierarquia].Obejt,   'Atenção: Margem Mínima menor a informada para os superiores hierárquicos!');
          pAjustaCor(arrHierarquia[LSecundario.getHierarquia].Obejt, clCorAlerta);
          pAjustaHnt(arrHierarquia[LSecundario.getHierarquia].Obejt, 'Atenção: Margem Mínima maior a informada para os subordinados hierárquicos!');
        End;
      End;

    End;

  End;

end;

procedure TValidaHierarquia.pAjustaCorAndHntDefault(AObject: TObject);
begin
  pAjustaCor(AObject, clCorNormal);
  pAjustaHnt(AObject, '');
end;

procedure TValidaHierarquia.pAjustaCor(AObject: TObject; clCor: TColor);
begin
  If Assigned(AObject) Then
  Begin
    If (AObject Is TDBEditFocus) Then
    Begin
      TDBEditFocus(AObject).Color         := clCor;
      TDBEditFocus(AObject).NormalColor   := clCor;
      TDBEditFocus(AObject).StyleElements := [seBorder];
    End;
  End;
end;

procedure TValidaHierarquia.pAjustaHnt(AObject: TObject; strHint: String);
begin
  If Assigned(AObject) Then
  Begin
    If (AObject Is TDBEditFocus) Then
    Begin
      TDBEditFocus(AObject).Hint     := strHint;
      TDBEditFocus(AObject).ShowHint := strHint <> '';
    End;
  End;
end;

procedure TValidaHierarquia.pLimpar;
begin
  FillChar(arrHierarquia, SizeOf(arrHierarquia), #0);
end;

procedure TValidaHierarquia.pSetGerente_Junior(AValue: Double; AObject: TObject=Nil);
begin

  If (AValue < 0) Then
  Begin
    pAjustaCorAndHntDefault(AObject);
    Exit;
  End;

  arrHierarquia[THierarquia.hGerente_Junior.getHierarquia].Valor := AValue;
  arrHierarquia[THierarquia.hGerente_Junior.getHierarquia].Obejt := AObject;

end;

procedure TValidaHierarquia.pSetGerente_Master(AValue: Double; AObject: TObject=Nil);
begin

  If (AValue < 0) Then
  Begin
    pAjustaCorAndHntDefault(AObject);
    Exit;
  End;

  arrHierarquia[THierarquia.hGerente_Master.getHierarquia].Valor := AValue;
  arrHierarquia[THierarquia.hGerente_Master.getHierarquia].Obejt := AObject;

end;

procedure TValidaHierarquia.pSetSubGerenJunior(AValue: Double; AObject: TObject=Nil);
begin

  If (AValue < 0) Then
  Begin
    pAjustaCorAndHntDefault(AObject);
    Exit;
  End;

  arrHierarquia[THierarquia.hSubGerenJunior.getHierarquia].Valor := AValue;
  arrHierarquia[THierarquia.hSubGerenJunior.getHierarquia].Obejt := AObject;

end;

procedure TValidaHierarquia.pSetSubGerenMaster(AValue: Double; AObject: TObject=Nil);
begin

  If (AValue < 0) Then
  Begin
    pAjustaCorAndHntDefault(AObject);
    Exit;
  End;

  arrHierarquia[THierarquia.hSubGerenMaster.getHierarquia].Valor := AValue;
  arrHierarquia[THierarquia.hSubGerenMaster.getHierarquia].Obejt := AObject;

end;

procedure TValidaHierarquia.pSetVendedorJunior(AValue: Double; AObject: TObject=Nil);
begin

  If (AValue < 0) Then
  Begin
    pAjustaCorAndHntDefault(AObject);
    Exit;
  End;

  arrHierarquia[THierarquia.hVendedorJunior.getHierarquia].Valor := AValue;
  arrHierarquia[THierarquia.hVendedorJunior.getHierarquia].Obejt := AObject;

end;

procedure TValidaHierarquia.pSetVendedorMaster(AValue: Double; AObject: TObject=Nil);
begin

  If (AValue < 0) Then
  Begin
    pAjustaCorAndHntDefault(AObject);
    Exit;
  End;

  arrHierarquia[THierarquia.hVendedorMaster.getHierarquia].Valor := AValue;
  arrHierarquia[THierarquia.hVendedorMaster.getHierarquia].Obejt := AObject;

end;

end.
