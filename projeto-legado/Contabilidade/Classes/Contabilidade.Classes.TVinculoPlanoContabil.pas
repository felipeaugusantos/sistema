unit Contabilidade.Classes.TVinculoPlanoContabil;

interface

uses
  System.Generics.Collections, System.SysUtils ;

type
  TPlanoType = (ptPlanoReferencial, ptPlanoContasFinanceiro, ptPortador) ;

  TPlancoComPlanoReferencial = class
  private
    Fselecionado: String ;
    Fautoincrem:  String ;
    Fnco_codcon:  String ;
    Fnco_descri:  String ;
    Fnco_ctaref:  String ;
    Fnre_descri:  String ;
  public
    property selecionado : String read Fselecionado write Fselecionado ;
    property autoincrem  : String read Fautoincrem write Fautoincrem ;
    property nco_codcon  : String read Fnco_codcon write Fnco_codcon ;
    property nco_descri  : String read Fnco_descri write Fnco_descri ;
    property nco_ctaref  : String read Fnco_ctaref write Fnco_ctaref ;
    property nre_descri  : String read Fnre_descri write Fnre_descri ;
  end ;

  TPlanre = class
  private
    Fselecionado: String ;
    Fnre_codref: String ;
    Fnre_descri: String ;
    Fnre_dtaini: String ;
    Fnre_dtafin: String ;
  public
    property selecionado: String read Fselecionado write Fselecionado ;
    property nre_codref:  String read Fnre_codref write Fnre_codref ;
    property nre_descri:  String read Fnre_descri write Fnre_descri ;
    property nre_dtaini:  String read Fnre_dtaini write Fnre_dtaini ;
    property nre_dtafin:  String read Fnre_dtafin write Fnre_dtafin ;
  end ;

  TNco = class
  private
    Fnco_codnco: String ;
    Fnco_codemp: String ;
    Fnco_codcon: String ;
    Fnco_descri: String ;
  public
    property nco_codnco: String read Fnco_codnco write Fnco_codnco ;
    property nco_codemp: String read Fnco_codemp write Fnco_codemp ;
    property nco_codcon: String read Fnco_codcon write Fnco_codcon ;
    property nco_descri: String read Fnco_descri write Fnco_descri ;
  end ;

  TCadBaseComPlanoContabil = class
  protected
    Fselecionado: String ;
    Fpor_empresa: String ;
    Fautoincrem: String ;
    FEmpresas: TObjectList<TNco> ;
  public
    property selecionado: String read Fselecionado write Fselecionado ;
    property por_empresa: String read Fpor_empresa write Fpor_empresa ;
    property autoincrem: String read Fautoincrem write Fautoincrem ;
    property empresas: TObjectList<TNco> read FEmpresas write FEmpresas ;
  end ;

  TCadCtaComPlanoContabil = class(TCadBaseComPlanoContabil)
  private
    Fcta_codcta: String ;
    Fcta_descta: String ;
    Fcta_planco: String ;
    Fnco_descri: String ;
  public
    constructor Create ;
    destructor Destroy ; override ;
    property cta_codcta: String read Fcta_codcta write Fcta_codcta ;
    property cta_descta: String read Fcta_descta write Fcta_descta ;
    property cta_planco: String read Fcta_planco write Fcta_planco ;
    property nco_descri: String read Fnco_descri write Fnco_descri ;
  end ;

  TCadPorComPlanoContabil = class(TCadBaseComPlanoContabil)
  private
    Fpor_codpor: String ;
    Fpor_nompor: String ;
    Fpor_planco: String ;
    Fnco_descri: String ;
  public
    constructor Create ;
    destructor Destroy ; override ;
    property por_codpor: String read Fpor_codpor write Fpor_codpor ;
    property por_nompor: String read Fpor_nompor write Fpor_nompor ;
    property por_planco: String read Fpor_planco write Fpor_planco ;
    property nco_descri: String read Fnco_descri write Fnco_descri ;
  end ;

  TPlanco = class
  private
    Fselecionado: String ;
    Fnco_codcon: String ;
    Fnco_descri: String ;
    Fnco_dtaini: String ;
    Fnco_dtafin: String ;
    Fautoincrem: String ;
  public
    property selecionado: String read Fselecionado write Fselecionado ;
    property nco_codcon: String read Fnco_codcon write Fnco_codcon ;
    property nco_descri: String read Fnco_descri write Fnco_descri ;
    property nco_dtaini: String read Fnco_dtaini write Fnco_dtaini ;
    property nco_dtafin: String read Fnco_dtafin write Fnco_dtafin ;
    property autoincrem: String read Fautoincrem write Fautoincrem ;
  end ;

implementation

{ TCadCtaComPlanoContabil }

constructor TCadCtaComPlanoContabil.Create;
begin
  FEmpresas := TObjectList<TNco>.Create();
end;

destructor TCadCtaComPlanoContabil.Destroy;
begin
  FreeAndNil(FEmpresas) ;
  inherited;
end;

{ TCadPorComPlanoContabil }

constructor TCadPorComPlanoContabil.Create;
begin
  FEmpresas := TObjectList<TNco>.Create();
end;

destructor TCadPorComPlanoContabil.Destroy;
begin
  FreeAndNil(FEmpresas) ;
  inherited;
end;

end.
