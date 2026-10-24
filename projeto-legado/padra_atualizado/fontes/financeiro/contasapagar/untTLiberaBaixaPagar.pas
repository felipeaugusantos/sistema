unit untTLiberaBaixaPagar;

interface

uses
  System.Generics.Collections, System.SysUtils, System.Classes;

type
  TLiberaBaixaPagar = class
  private
    FListaAutoIncrems: TStringList;

    FNomeForm: String;
  public
    constructor Create(strNomeForm: String); reintroduce;
    destructor Destroy; override;
    procedure pLimpaDados;
    procedure pAddPagar(strAutoincrem: String);
    procedure pLiberar;
    procedure pCancLiberacao(strAutoincrem: String);
  end;

implementation

{ TLfiberaBaixaPagar }

uses untFuncoesSimples, untObjectManager, untLogCtp;

constructor TLiberaBaixaPagar.Create(strNomeForm: String);
begin
  inherited Create;
  FNomeForm := strNomeForm;
  FListaAutoIncrems := TStringList.Create;
end;

destructor TLiberaBaixaPagar.Destroy;
begin
  FreeAndNil(FListaAutoIncrems);
  inherited;
end;

procedure TLiberaBaixaPagar.pAddPagar(strAutoincrem: String);
begin
  FListaAutoIncrems.Add(strAutoincrem);
end;

procedure TLiberaBaixaPagar.pCancLiberacao(strAutoincrem: String);
begin
  fExecutaSQL('UPDATE CADPAG SET ' +
              '  CTP_DTALIB=NULL, ' +
              '  CTP_HORLIB=NULL, ' +
              '  CTP_OPELIB=NULL ' +
              'WHERE AUTOINCREM="' + strAutoincrem + '"', True);

  untLogCtp.GravaLogCtp(strAutoincrem,
                        'TORNAR PEND. LIBERAÇÃO DE BAIXA DE CONTAS A PAGAR',
                        FNomeForm);
end;

procedure TLiberaBaixaPagar.pLiberar;
  Var
    LAutoIncrem: String;
begin
  For LAutoIncrem In FListaAutoIncrems Do
  Begin
    fExecutaSQL('UPDATE CADPAG SET ' +
                '  CTP_DTALIB=CURRENT_DATE, ' +
                '  CTP_HORLIB=CURRENT_TIME, ' +
                '  CTP_OPELIB="' + strLoginUsuarioLogado + '" ' +
                'WHERE AUTOINCREM="' + LAutoIncrem + '"', True);

    untLogCtp.GravaLogCtp(LAutoIncrem,
                          'LIBERAÇÃO DE BAIXA DE CONTAS A PAGAR',
                          FNomeForm);
  End;
end;

procedure TLiberaBaixaPagar.pLimpaDados;
begin
  FListaAutoIncrems.Clear;
end;

end.
